/*
 * SPDX-FileCopyrightText: Copyright © 2020-2023 Serpent OS Developers
 *
 * SPDX-License-Identifier: Zlib
 */

/**
 * summit.projects.profile
 *
 * Profile management
 *
 * Authors: Copyright © 2020-2023 Serpent OS Developers
 * License: Zlib
 */

module summit.projects.profile;

import moss.client.metadb;
import moss.core.errors;
import moss.service.context;
import std.file : mkdirRecurse;
import std.path : buildPath;
import summit.models;
import summit.projects.project;
import vibe.d;

/**
 * Provides runtime encapsulation and management of build profiles.
 * Each build profile belongs to a specific Project and defines the
 * build configuration, as well as the publication index.
 *
 * Multiple profiles can (and do) exist for each project, especially
 * for multiple-architectures
 */
public final class ManagedProfile
{
    @disable this();

    /**
     * Construct a new ManagedProfile
     *
     * Params:
     *      project = The owning project for this profile
     *      model = Backing model (already exists in the DB)
     */
    this(ServiceContext context, ManagedProject project, Profile model) @safe
    {
        this.context = context;
        this._model = model;
        this._project = project;
        this._dbPath = context.dbPath.buildPath("profiles", to!string(model.id));
        this._cachePath = context.cachePath.buildPath("profiles", to!string(model.id));

        /* Always ensure directories exist */
        cachePath.mkdirRecurse();
        dbPath.mkdirRecurse();

        /* Create a new MetaDB for the index. Initially empty. */
        indexDB = new MetaDB(dbPath, true);
    }

    /**
     * Returns: Underlying model
     */
    pure @property Profile profile() @safe @nogc nothrow
    {
        return _model;
    }

    /**
     * Returns: Parent Project
     */
    pure @property ManagedProject project() @safe @nogc nothrow
    {
        return _project;
    }

    /**
     * Returns: Our profile specific db path
     */
    pure @property string dbPath() @safe @nogc nothrow const
    {
        return _dbPath;
    }

    /**
     * Returns: Our profile specific cache path
     */
    pure @property string cachePath() @safe @nogc nothrow const
    {
        return _cachePath;
    }

    /**
     * Connect the underlying storage
     *
     * Returns: matchable error
     */
    auto connect() @safe
    {
        return indexDB.connect();
    }

private:

    Profile _model;
    ServiceContext context;
    ManagedProject _project;
    string _dbPath;
    string _cachePath;
    MetaDB indexDB;
}
