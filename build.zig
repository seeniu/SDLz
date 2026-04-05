const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const sdl3 = b.addLibrary(.{
        .name = "sdl3",
        .linkage = .static,
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });

    sdl3.addIncludePath(b.path("include"));
    sdl3.addIncludePath(b.path("include/build_config"));
    sdl3.addIncludePath(b.path("src"));

    const common_cflags = [_][]const u8{
        "-DSDL_BUILD_MAJOR_VERSION=3",
        "-DSDL_BUILD_MINOR_VERSION=5",
        "-DSDL_BUILD_MICRO_VERSION=0",
        "-DSDL_STATIC_LIB",
    };

    const common_sources = [_][]const u8{
        "src/SDL.c",
        "src/SDL_assert.c",
        "src/SDL_error.c",
        "src/SDL_guid.c",
        "src/SDL_hashtable.c",
        "src/SDL_hints.c",
        "src/SDL_list.c",
        "src/SDL_log.c",
        "src/SDL_properties.c",
        "src/SDL_utils.c",
        "src/atomic/SDL_atomic.c",
        "src/atomic/SDL_spinlock.c",
        "src/audio/SDL_audio.c",
        "src/audio/SDL_audiocvt.c",
        "src/audio/SDL_audiodev.c",
        "src/audio/SDL_audioqueue.c",
        "src/audio/SDL_mixer.c",
        "src/audio/SDL_wave.c",
        "src/audio/SDL_audioresample.c",
        "src/audio/SDL_audiotypecvt.c",
        "src/camera/SDL_camera.c",
        "src/cpuinfo/SDL_cpuinfo.c",
        "src/dialog/SDL_dialog.c",
        "src/dynapi/SDL_dynapi.c",
        "src/events/SDL_categories.c",
        "src/events/SDL_clipboardevents.c",
        "src/events/SDL_displayevents.c",
        "src/events/SDL_dropevents.c",
        "src/events/SDL_events.c",
        "src/events/SDL_eventwatch.c",
        "src/events/SDL_keyboard.c",
        "src/events/SDL_keymap.c",
        "src/events/SDL_mouse.c",
        "src/events/SDL_pen.c",
        "src/events/SDL_quit.c",
        "src/events/SDL_scancode_tables.c",
        "src/events/SDL_touch.c",
        "src/events/SDL_windowevents.c",
        "src/filesystem/SDL_filesystem.c",
        "src/gpu/SDL_gpu.c",
        "src/haptic/SDL_haptic.c",
        "src/hidapi/SDL_hidapi.c",
        "src/io/SDL_asyncio.c",
        "src/io/SDL_iostream.c",
        "src/joystick/SDL_gamepad.c",
        "src/joystick/SDL_joystick.c",
        "src/joystick/controller_type.c",
        "src/libm/e_atan2.c",
        "src/libm/e_exp.c",
        "src/libm/e_fmod.c",
        "src/libm/e_log.c",
        "src/libm/e_log10.c",
        "src/libm/e_pow.c",
        "src/libm/e_rem_pio2.c",
        "src/libm/e_sqrt.c",
        "src/libm/k_cos.c",
        "src/libm/k_rem_pio2.c",
        "src/libm/k_sin.c",
        "src/libm/s_atan.c",
        "src/libm/s_copysign.c",
        "src/libm/s_cos.c",
        "src/libm/s_fabs.c",
        "src/libm/s_floor.c",
        "src/libm/s_isinf.c",
        "src/libm/s_isinff.c",
        "src/libm/s_isnan.c",
        "src/libm/s_isnanf.c",
        "src/libm/s_modf.c",
        "src/libm/s_scalbn.c",
        "src/libm/s_sin.c",
        "src/libm/s_tan.c",
        "src/locale/SDL_locale.c",
        "src/main/SDL_runapp.c",
        "src/misc/SDL_url.c",
        "src/power/SDL_power.c",
        "src/process/SDL_process.c",
        "src/render/SDL_render.c",
        "src/render/SDL_render_unsupported.c",
        "src/render/SDL_yuv_sw.c",
    };
    sdl3.addCSourceFiles(.{
        .files = &common_sources,
        .flags = &common_cflags,
    });

    if (target.result.os.tag == .windows) {
        const windows_cflags = [_][]const u8{
            "-DSDL_BUILD_MAJOR_VERSION=3",
            "-DSDL_BUILD_MINOR_VERSION=5",
            "-DSDL_BUILD_MICRO_VERSION=0",
            "-DSDL_STATIC_LIB",
            "-DWIN32",
            "-D_WIN32",
            "-DSDL_VIDEO_DRIVER_WINDOWS=1",
            "-DSDL_AUDIO_DRIVER_WASAPI=1",
            "-DSDL_AUDIO_DRIVER_DSOUND=1",
            "-DSDL_AUDIO_DRIVER_WINMM=1",
            "-DSDL_JOYSTICK_HIDAPI=1",
            "-DSDL_HAPTIC_WINDOWS=1",
            "-DSDL_POWER_WINDOWS=1",
            "-DSDL_FILESYSTEM_WINDOWS=1",
            "-DSDL_LOADSO_WINDOWS=1",
            "-DSDL_THREAD_WINDOWS=1",
            "-DSDL_TIMER_WINDOWS=1",
            "-DSDL_CORE_WINDOWS=1",
            "-DSDL_CAMERA_MEDIAFOUNDATION=1",
            "-D_CRT_SECURE_NO_WARNINGS",
            "-DSDL_VIDEO_OPENGL_ES=0",
            "-DSDL_VIDEO_OPENGL_ES2=0",
            "-DSDL_VIDEO_OPENGLES=0",
            "-DSDL_VIDEO_VULKAN=0",
            "-DSDL_VIDEO_OPENGL_EGL=0",
            "-DSDL_USE_BUILTIN_OPENGL_DEFINITIONS=1",
        };

        const windows_sources = [_][]const u8{
            "src/audio/dummy/SDL_dummyaudio.c",
            "src/audio/wasapi/SDL_wasapi.c",
            "src/audio/directsound/SDL_directsound.c",
            "src/core/windows/SDL_hid.c",
            "src/core/windows/SDL_windows.c",
            "src/core/windows/SDL_immdevice.c",
            "src/core/windows/SDL_xinput.c",
            "src/core/windows/pch.c",
            "src/dialog/windows/SDL_windowsdialog.c",
            "src/filesystem/windows/SDL_sysfilesystem.c",
            "src/haptic/windows/SDL_dinputhaptic.c",
            "src/haptic/windows/SDL_windowshaptic.c",
            "src/hidapi/windows/hid.c",
            "src/joystick/windows/SDL_windowsjoystick.c",
            "src/joystick/windows/SDL_xinputjoystick.c",
            "src/loadso/windows/SDL_sysloadso.c",
            "src/misc/windows/SDL_sysurl.c",
            "src/power/windows/SDL_syspower.c",
            "src/render/direct3d/SDL_render_d3d.c",
            "src/render/opengl/SDL_render_gl.c",
            "src/render/software/SDL_blendfillrect.c",
            "src/render/software/SDL_blendline.c",
            "src/render/software/SDL_blendpoint.c",
            "src/render/software/SDL_drawline.c",
            "src/render/software/SDL_drawpoint.c",
            "src/render/software/SDL_render_sw.c",
            "src/render/software/SDL_triangle.c",
            "src/thread/generic/SDL_syscond.c",
            "src/thread/windows/SDL_sysmutex.c",
            "src/thread/windows/SDL_syssem.c",
            "src/thread/windows/SDL_systhread.c",
            "src/thread/windows/SDL_systls.c",
            "src/timer/windows/SDL_systimer.c",
            "src/video/dummy/SDL_nullevents.c",
            "src/video/dummy/SDL_nullframebuffer.c",
            "src/video/dummy/SDL_nullvideo.c",
            "src/video/windows/SDL_windowsclipboard.c",
            "src/video/windows/SDL_windowsevents.c",
            "src/video/windows/SDL_windowsframebuffer.c",
            "src/video/windows/SDL_windowskeyboard.c",
            "src/video/windows/SDL_windowsmessagebox.c",
            "src/video/windows/SDL_windowsmodes.c",
            "src/video/windows/SDL_windowsmouse.c",
            "src/video/windows/SDL_windowsopengl.c",
            "src/video/windows/SDL_windowsshape.c",
            "src/video/windows/SDL_windowsvideo.c",
            "src/video/windows/SDL_windowswindow.c",
            "src/video/windows/SDL_windowsrawinput.c",
        };
        sdl3.addCSourceFiles(.{
            .files = &windows_sources,
            .flags = &windows_cflags,
        });
        sdl3.linkSystemLibrary("gdi32");
        sdl3.linkSystemLibrary("winmm");
        sdl3.linkSystemLibrary("imm32");
        sdl3.linkSystemLibrary("version");
        sdl3.linkSystemLibrary("oleaut32");
        sdl3.linkSystemLibrary("ole32");
        sdl3.linkSystemLibrary("setupapi");
        sdl3.linkSystemLibrary("shell32");
        sdl3.linkSystemLibrary("user32");
        sdl3.linkSystemLibrary("advapi32");
        sdl3.linkSystemLibrary("dxguid");
        sdl3.linkSystemLibrary("dinput8");
    }

    b.installArtifact(sdl3);
}
