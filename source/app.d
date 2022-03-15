/* SPDX-License-Identifier: Zlib */

/**
 * Main entry point
 *
 * Authors: © 2020-2022 Serpent OS Developers
 * License: ZLib
 */
module main;

import vibe.vibe;

void main()
{
    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.bindAddresses = ["::1", "127.0.0.1"];
    auto listener = listenHTTP(settings, &hello);
    scope (exit)
    {
        listener.stopListening();
    }

    logInfo("Please open http://127.0.0.1:8080/ in your browser.");
    runApplication();
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
    res.writeBody("Hello, World!");
}
