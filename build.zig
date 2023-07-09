const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mbedtls = b.addStaticLibrary(.{
        .name = "mbedtls",
        .target = target,
        .optimize = optimize,
    });

    mbedtls.addIncludePath("include");
    mbedtls.addCSourceFiles(srcs, &.{});
    mbedtls.linkLibC();

    if (target.isWindows())
        mbedtls.linkSystemLibraryName("ws2_32");

    for (headers) |header|
        mbedtls.installHeader(header, header["include/".len..]);

    b.installArtifact(mbedtls);

    const selftest = b.addExecutable(.{ .name = "selftest" });
    selftest.addCSourceFile("programs/test/selftest.c", &.{});
    selftest.defineCMacro("MBEDTLS_SELF_TEST", null);
    selftest.linkLibrary(mbedtls);

    const run_selftest = b.addRunArtifact(selftest);
    const test_step = b.step("test", "Run mbedtls selftest");
    test_step.dependOn(&run_selftest.step);
}

const srcs: []const []const u8 = &.{
    "library/aes.c",
    "library/aesce.c",
    "library/aesni.c",
    "library/aria.c",
    "library/asn1parse.c",
    "library/asn1write.c",
    "library/base64.c",
    "library/bignum.c",
    "library/bignum_core.c",
    "library/bignum_mod.c",
    "library/bignum_mod_raw.c",
    "library/camellia.c",
    "library/ccm.c",
    "library/chacha20.c",
    "library/chachapoly.c",
    "library/cipher.c",
    "library/cipher_wrap.c",
    "library/cmac.c",
    "library/constant_time.c",
    "library/ctr_drbg.c",
    "library/debug.c",
    "library/des.c",
    "library/dhm.c",
    "library/ecdh.c",
    "library/ecdsa.c",
    "library/ecjpake.c",
    "library/ecp.c",
    "library/ecp_curves.c",
    "library/entropy.c",
    "library/entropy_poll.c",
    "library/error.c",
    "library/gcm.c",
    "library/hash_info.c",
    "library/hkdf.c",
    "library/hmac_drbg.c",
    "library/lmots.c",
    "library/lms.c",
    "library/md.c",
    "library/md5.c",
    "library/memory_buffer_alloc.c",
    "library/mps_reader.c",
    "library/mps_trace.c",
    "library/net_sockets.c",
    "library/nist_kw.c",
    "library/oid.c",
    "library/padlock.c",
    "library/pem.c",
    "library/pk.c",
    "library/pk_wrap.c",
    "library/pkcs12.c",
    "library/pkcs5.c",
    "library/pkcs7.c",
    "library/pkparse.c",
    "library/pkwrite.c",
    "library/platform.c",
    "library/platform_util.c",
    "library/poly1305.c",
    "library/psa_crypto.c",
    "library/psa_crypto_aead.c",
    "library/psa_crypto_cipher.c",
    "library/psa_crypto_client.c",
    "library/psa_crypto_driver_wrappers.c",
    "library/psa_crypto_ecp.c",
    "library/psa_crypto_hash.c",
    "library/psa_crypto_mac.c",
    "library/psa_crypto_pake.c",
    "library/psa_crypto_rsa.c",
    "library/psa_crypto_se.c",
    "library/psa_crypto_slot_management.c",
    "library/psa_crypto_storage.c",
    "library/psa_its_file.c",
    "library/psa_util.c",
    "library/ripemd160.c",
    "library/rsa.c",
    "library/rsa_alt_helpers.c",
    "library/sha1.c",
    "library/sha256.c",
    "library/sha512.c",
    "library/ssl_cache.c",
    "library/ssl_ciphersuites.c",
    "library/ssl_client.c",
    "library/ssl_cookie.c",
    "library/ssl_debug_helpers_generated.c",
    "library/ssl_msg.c",
    "library/ssl_ticket.c",
    "library/ssl_tls.c",
    "library/ssl_tls12_client.c",
    "library/ssl_tls12_server.c",
    "library/ssl_tls13_client.c",
    "library/ssl_tls13_generic.c",
    "library/ssl_tls13_keys.c",
    "library/ssl_tls13_server.c",
    "library/threading.c",
    "library/timing.c",
    "library/version.c",
    "library/version_features.c",
    "library/x509.c",
    "library/x509_create.c",
    "library/x509_crl.c",
    "library/x509_crt.c",
    "library/x509_csr.c",
    "library/x509write_crt.c",
    "library/x509write_csr.c",
};

const headers: []const []const u8 = &.{
    "include/mbedtls/aes.h",
    "include/mbedtls/aria.h",
    "include/mbedtls/asn1.h",
    "include/mbedtls/asn1write.h",
    "include/mbedtls/base64.h",
    "include/mbedtls/bignum.h",
    "include/mbedtls/build_info.h",
    "include/mbedtls/camellia.h",
    "include/mbedtls/ccm.h",
    "include/mbedtls/chacha20.h",
    "include/mbedtls/chachapoly.h",
    "include/mbedtls/check_config.h",
    "include/mbedtls/cipher.h",
    "include/mbedtls/cmac.h",
    "include/mbedtls/compat-2.x.h",
    "include/mbedtls/config_psa.h",
    "include/mbedtls/constant_time.h",
    "include/mbedtls/ctr_drbg.h",
    "include/mbedtls/debug.h",
    "include/mbedtls/des.h",
    "include/mbedtls/dhm.h",
    "include/mbedtls/ecdh.h",
    "include/mbedtls/ecdsa.h",
    "include/mbedtls/ecjpake.h",
    "include/mbedtls/ecp.h",
    "include/mbedtls/entropy.h",
    "include/mbedtls/error.h",
    "include/mbedtls/gcm.h",
    "include/mbedtls/hkdf.h",
    "include/mbedtls/hmac_drbg.h",
    "include/mbedtls/legacy_or_psa.h",
    "include/mbedtls/lms.h",
    "include/mbedtls/mbedtls_config.h",
    "include/mbedtls/md.h",
    "include/mbedtls/md5.h",
    "include/mbedtls/memory_buffer_alloc.h",
    "include/mbedtls/net_sockets.h",
    "include/mbedtls/nist_kw.h",
    "include/mbedtls/oid.h",
    "include/mbedtls/pem.h",
    "include/mbedtls/pk.h",
    "include/mbedtls/pkcs12.h",
    "include/mbedtls/pkcs5.h",
    "include/mbedtls/pkcs7.h",
    "include/mbedtls/platform.h",
    "include/mbedtls/platform_time.h",
    "include/mbedtls/platform_util.h",
    "include/mbedtls/poly1305.h",
    "include/mbedtls/private_access.h",
    "include/mbedtls/psa_util.h",
    "include/mbedtls/ripemd160.h",
    "include/mbedtls/rsa.h",
    "include/mbedtls/sha1.h",
    "include/mbedtls/sha256.h",
    "include/mbedtls/sha512.h",
    "include/mbedtls/ssl.h",
    "include/mbedtls/ssl_cache.h",
    "include/mbedtls/ssl_ciphersuites.h",
    "include/mbedtls/ssl_cookie.h",
    "include/mbedtls/ssl_ticket.h",
    "include/mbedtls/threading.h",
    "include/mbedtls/timing.h",
    "include/mbedtls/version.h",
    "include/mbedtls/x509.h",
    "include/mbedtls/x509_crl.h",
    "include/mbedtls/x509_crt.h",
    "include/mbedtls/x509_csr.h",
    "include/psa/crypto.h",
    "include/psa/crypto_builtin_composites.h",
    "include/psa/crypto_builtin_primitives.h",
    "include/psa/crypto_compat.h",
    "include/psa/crypto_config.h",
    "include/psa/crypto_driver_common.h",
    "include/psa/crypto_driver_contexts_composites.h",
    "include/psa/crypto_driver_contexts_primitives.h",
    "include/psa/crypto_extra.h",
    "include/psa/crypto_platform.h",
    "include/psa/crypto_se_driver.h",
    "include/psa/crypto_sizes.h",
    "include/psa/crypto_struct.h",
    "include/psa/crypto_types.h",
    "include/psa/crypto_values.h",
};