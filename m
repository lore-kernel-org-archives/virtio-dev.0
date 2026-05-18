Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292463815F3
	for <virtio-dev@lists.linux.dev>; Mon, 18 May 2026 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093895; cv=none; b=Ofw5iJxAMCS7pNczA/7Np5995v0pKCLtSgXM1pBYvi4KZO7XgEyP5gwYSygJWy3Ld0MO1kbqYZ1Nc9/b2v6dli66U5AD6THsr4gTh6bmJEjjXOs3f5npkqapylN/1zMvUyAxKAifedPUoJXjt22vqoGqOeqbflag3RFSCKiptSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093895; c=relaxed/simple;
	bh=J3TdbTKN+6jsEFYBVrI61aEDvvOtX8coPMu7jiBXh/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KfdPN36taMjp6F9Bi01ZtPyJOf9u9fABehLjFXnHnZQIKQ8pfjtot9/No9xChXJJbX/47NdeZIXZtT4Mj8XvvxyMoQYEAshTmhhxmXdNMIP0c7qMcGEzbNtnhCsVNkNit4wTdLeZU2lfxAE2Bm3Es4BwMgsyd9vdGvuUMnQoIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JP0EcO0E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JP0EcO0E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779093892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tvDmvDzchHkNMk3o3t7Z6hTNydMK2OYHdgG/vThA+Y=;
	b=JP0EcO0EThpyaprvNwfXylHSOqDSOKxp5lNt63uZptzBzlT6RNCqUvrbGH16sn5dCfFSWO
	zfXUXF0ufy/llpP04KdAg/NgS6M4oj8rMven+o+QRpZCkbm26lH+j90bW/0amgiycDA077
	1G2G277hsuRcUIRTsRVoHUYh+rmTa3A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-f12AvTYdNLKLgt-mEvmmUg-1; Mon, 18 May 2026 04:44:50 -0400
X-MC-Unique: f12AvTYdNLKLgt-mEvmmUg-1
X-Mimecast-MFC-AGG-ID: f12AvTYdNLKLgt-mEvmmUg_1779093890
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd396daedso14380775e9.0
        for <virtio-dev@lists.linux.dev>; Mon, 18 May 2026 01:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779093889; x=1779698689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tvDmvDzchHkNMk3o3t7Z6hTNydMK2OYHdgG/vThA+Y=;
        b=Dc4IeMSLILWKsBc82aB31iIJJZc2QxETonZB4FGsZv3USxLS4LwK3WD2d+UziGUQni
         oZ2ntt9Qm9G5c0eU4yJF66KtVimMbMwZsqjNeW5/37hw/7XBdy6OlRycxstp1pH/60s4
         QvkdGHiEosBdiSlC/F/2m87RJK7Uz+OftODqH09lhPsRRaVJaeJ0wlzAUXuPoUCs8jpw
         Dnzw4bt7AM2orkRI/E99eHEbptDfjPLNcayQiw2KNZO+8a8TIS1A3ez/qRb68DP1g2zb
         8+XhQi4ZHTB8hi2esh4Hs96jqMivJaYTZB50A5UrGgSD+pVbCYOcwKZ0n/g5n4GR+zvX
         BHEA==
X-Gm-Message-State: AOJu0Yw+8AO+nqWKcpn7sQPeYWOh+mME9L5ljtTJZS3KAi+3HU0R3aaN
	ZLP/XHOxsaCqPzQ9NicMuiRV/1xtCGEXLoverZMQrLjG0HrBi0DVhQdDFX6F23nEafR4YICtMHY
	7NpMaqq3K37r+mYUYl/YziqG2FzkLmclT6DlzJSK5FKgnA8BnGVS1xtd6G7C33omWzGqmVsg=
X-Gm-Gg: Acq92OEf4K7dzXexYrqwyk0s4RIskRVfJAG0jX4wbtVKEvoJy5/UABfSe/nS6SzYxlp
	rkJYj1jUQTTptfvOn7g+tE0+VwIVgaRvc2nIW2GQd2+kTfwF8dk0PZO8TNkx07hzkgy2levnaTG
	6OB5R+pWEdm2n/a6ZH2gnqEKvouSI0e0ep97UW9y1acaJkLimPJPu5nrT0glfGsYwYz4+uH2U/V
	rDUt5EFcE1pRC47zbpqeIAnd4wTh8szS/foTJjUQdNF50+RFtQ6eKZS3ptzZxrqOAIL9Wp1eF3r
	vwJm8+GkpceNhxgHQuMxGbfYjWsVe5ljUnVe8M7pheRlpa164AWyQyo2NNUxwJkQ9y+396xz18t
	vhejfrBziLx+UnvvhAoA9fnvLHJeL3H1iP9bvGbiocc5Z8SALLi4=
X-Received: by 2002:a05:600c:4fc9:b0:48a:5821:5ffc with SMTP id 5b1f17b1804b1-48fe60e473bmr189541915e9.2.1779093889302;
        Mon, 18 May 2026 01:44:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:48a:5821:5ffc with SMTP id 5b1f17b1804b1-48fe60e473bmr189541225e9.2.1779093888690;
        Mon, 18 May 2026 01:44:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c516sm260116735e9.13.2026.05.18.01.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:44:48 -0700 (PDT)
Date: Mon, 18 May 2026 04:44:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: VirtIO Dev List <virtio-dev@lists.linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>, manos@pitsidianak.is
Subject: Re: Rust virtio drivers in Linux
Message-ID: <20260518043103-mutt-send-email-mst@kernel.org>
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
 <CAAjaMXaOm=sOjO4ksM-PcOf4wqez9+ePBdv9U7prHiVaCx7-+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAjaMXaOm=sOjO4ksM-PcOf4wqez9+ePBdv9U7prHiVaCx7-+Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KkBbPuMQKYdz227hnNsFNRIq_FWmB4I4RH1e5VWxW9w_1779093890
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 18, 2026 at 11:12:06AM +0300, Manos Pitsidianakis wrote:
> Hello all,
> 
> I have a new device type proposal for the virtio spec I hope to
> publish to virtio-comment soon and I have a reference C driver
> implementation for Linux. However I would prefer to implement the
> driver in Rust, and should it be accepted upstream, abandon the C
> driver out-of-tree.
> 
> In preparation for that, I wrote bindings for the virtio subsystem and
> sent them to LKML. I had forgotten to CC virtio-dev.
> 
> The RFC I sent 2 weeks ago has a sample virtio-rtc driver that doesn't
> register itself to the rtc subsystem. Since then I wrote a virtio-rng
> driver instead that is fully equivalent to the C driver. I haven't
> sent it yet because my last revision did not receive any comments yet.
> My WIP tree is https://github.com/epilys/linux/tree/rust-virtio

Yea, sorry I didn't start reviewing yet. My problem is my rust knowledge is
limited, and kernel rust - nonexistent. I did the crab book a while ago
but didn't do much since except a small terminal emulator project.

> I'd like to hear any feedback and suggestions, especially from the
> kernel virtio and Rust maintainers.
> 
> Note: An issue with virtio drivers is that they require bindings both
> for virtio and the device subsystem. For example I had to write hwrng
> bindings for the virtio-rng driver. Does this require more
> co-operation from kernel maintainers in order to get things merged?

Well the rust kernel doc at Documentation/rust/general-information.rst
says you are supposed to also write
"abstractions" as opposed to just "bindings" and they have to
be "ergonomic". I will be frank I'm not the best judge
about "egonomic". So yes, more kernel maintainers who understand
this thing would help a lot.

> Miguel: WDYT?
> 
> Thanks in advance!
> 
> ---------- Forwarded message ---------
> From: Manos Pitsidianakis <manos@pitsidianak.is>
> Date: Sun, May 10, 2026 at 4:38 PM
> Subject: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
> To: Miguel Ojeda <ojeda@kernel.org>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Hilber
> <peter.hilber@oss.qualcomm.com>, Stefano Garzarella
> <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Viresh
> Kumar <viresh.kumar@linaro.org>, Michael S. Tsirkin <mst@redhat.com>,
> Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Björn Roy
> Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
> Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
> <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
> Krummrich <dakr@kernel.org>, Daniel Almeida
> <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
> Jason Wang <jasowang@redhat.com>, Xuan Zhuo
> <xuanzhuo@linux.alibaba.com>, Eugenio Pérez <eperezma@redhat.com>,
> <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
> Manos Pitsidianakis <manos@pitsidianak.is>
> 
> 
> Hi all, this RFC series adds Rust bindings for Virtio drivers
> (frontends in virtio parlance).
> 
> As a PoC, it also adds a sample virtio-rtc driver which performs
> capability discovery through the virtqueue without registering any clock.
> 
> Before I send a cleaned-up non-RFC I would like some initial feedback
> (i.e. is it something the upstream wants?)
> 
> This was tested with the rust-vmm vhost-device-rtc device backend that I
> wrote[^0]:
> 
> [^0]: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rtc
> 
> Instructions:
> 
>   Run the daemon in a separate terminal:
> 
>   $ cargo run --bin vhost-device-rtc -- -s /tmp/rtc.sock
> 
>   Then run the VM:
> 
>   $ qemu-system-aarch64 \
>     -machine type=virt,virtualization=off,acpi=on \
>     -cpu host \
>     -smp 8 \
>     -accel kvm \
>     -drive if=virtio,format=qcow2,file=./debian-13-nocloud-arm64-daily.qcow2 \
>     -device virtio-net-pci,netdev=unet \
>     -device virtio-scsi-pci \
>     -serial mon:stdio \
>     -m 8192 \
>     -object memory-backend-memfd,id=mem,size=8G,share=on \
>     -numa node,memdev=mem \
>     -display none \
>     -vga none \
>     -kernel /path/to/linux/build/arch/arm64/boot/Image \
>     -device vhost-user-test-device,chardev=rtc,id=rtc,virtio-id=17,num_vqs=2,vq_size=1024
> \
>     -chardev socket,path=/tmp/rtc.sock,id=rtc \
>     ...
> 
>   Example output:
>     [    1.105238] rust_virtio_rtc: Probe Rust virtio driver sample.
>     [    1.105645] rust_virtio_rtc: Found 1 vqs.
>     [    1.136050] rust_virtio_rtc: process_requestq got buf 16 bytes
>     [    1.136125] rust_virtio_rtc: Got response! Ok(RespCfg { head:
> ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
> num_clocks: Le16(3), reserved: [0, 0, 0, 0, 0, 0] })
>     [    1.136701] rust_virtio_rtc: Got response! Ok(RespClockCap {
> head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
> clock_type: 3, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0,
> 0, 0] })
>     [    1.136724] rust_virtio_rtc virtio0: cannot expose clock 0
> (type 3, variant 0, flags 0) to userspace
>     [    1.137259] rust_virtio_rtc: Got response! Ok(RespRead { head:
> ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
> clock_reading: Le64(1777890485031060388) })
>     [    1.137277] rust_virtio_rtc: #0 clock reading = 1777890485031060388
>     [    1.137749] rust_virtio_rtc: Got response! Ok(RespClockCap {
> head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
> clock_type: 1, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0,
> 0, 0] })
>     [    1.137769] rust_virtio_rtc virtio0: cannot expose clock 1
> (type 1, variant 0, flags 0) to userspace
>     [    1.138247] rust_virtio_rtc: Got response! Ok(RespRead { head:
> ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
> clock_reading: Le64(1777890485032086075) })
>     [    1.138264] rust_virtio_rtc: #1 clock reading = 1777890485032086075
>     [    1.138730] rust_virtio_rtc: Got response! Ok(RespClockCap {
> head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
> clock_type: 2, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0,
> 0, 0] })
>     [    1.138751] rust_virtio_rtc virtio0: cannot expose clock 2
> (type 2, variant 0, flags 0) to userspace
>     [    1.139253] rust_virtio_rtc: Got response! Ok(RespRead { head:
> ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
> clock_reading: Le64(338567896865557) })
>     [    1.139270] rust_virtio_rtc: #2 clock reading = 338567896865557
> 
> Concerns - Notes - TODOs
> ========================
> 
> - Virtqueue lifetimes don't neatly apply to Rust as expected, so a lot
>   of times we have to go through unsafe pointer dereferences (though
>   which are guaranteed by Virtio subsystem to be valid, for example when
>   a callback is called with the vq argument). There's a potential for
>   misuse and definitely could use better thinking.
> - `struct virtio_device` is not reference-counted like other implemented
>   device types in rust/kernel. Maybe we need to change C API first to
>   make them reference counted, assuming this doesn't break anything?
> - The sample driver obviously conflicts with the C implementation, so
>   this would either need to move out of samples/ or figure out some way
>   to handle this in kbuild.
> - kernel::virtio module and its types need a few rustdoc examples that I
>   will add in followup series
> - Note that the registration of RTC clocks etc in the sample driver is
>   not done, I'm putting it off until I receive some feedback first. The
>   sample driver otherwise does send and receive data from the virtqueue
>   as a PoC.
> 
> PS: No LLMs used so any mistakes and goofs are solely written by me.
> 
> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
> ---
> Changes in v3:
> - Removed unused methods from virtio API
> - Clean up how scattergather lists are added to virtqueues by using
>   owned SGTables only, and make the API safe(r)
> - Add RAII cleanup for find_vqs return value that calls del_vqs
> - Reset device after remove callback
> - Significantly clean up sample driver as a result of the other cleanups
> - Link to v2: https://lore.kernel.org/r/20260509-rust-virtio-v2-0-c1e30ec2bd21@pitsidianak.is
> 
> Changes in v2:
> - Move helper ifdefs to helper file (thanks Alice)
> - Changed CONFIG checks to IS_ENABLED to allow for CONFIG_VIRTIO=m
> - Split all use imports to one item per line according to style guide
> - Fixed wait_for_completion_interruptible*() rustdocs
> - Use Jiffy type alias in wait_for_completion_interruptible_timeout()
> - Pepper and salt #[inline]s wherever appropriate as per style guide
> - Split probe() into probe() and init() to allow cleaning up if init
>   fails
> - Remove unnecessary Send and Sync unsafe impls for
>   kernel::virtio::Device
> - Remove unnecessary LeSize and BeSize
> - Accept Option<_> for virtqueue callback when creating a VirtqueueInfo
> - Made all vq buffer adding operations unsafe
> - Use AtomicU16 instead of Cell<u16> for sample virtio driver
> - Fix RespHead field types in sample virtio driver
> - Fix response error checking in sample virtio driver
> - Change some device contexts in method signatures
> - Link to v1: https://lore.kernel.org/r/20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is
> 
> ---
> Manos Pitsidianakis (6):
>       rust/bindings: generate virtio bindings
>       rust/helpers: add virtio.c
>       rust/kernel/device: return parent at same context
>       rust: add virtio module
>       rust: impl interruptible waits for Completion
>       samples/rust: Add sample virtio-rtc driver [WIP]
> 
>  MAINTAINERS                     |   9 +
>  rust/bindings/bindings_helper.h |   5 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/virtio.c           |  37 ++++
>  rust/kernel/device.rs           |   2 +-
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/sync/completion.rs  |  42 +++-
>  rust/kernel/virtio.rs           | 423 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/virtio/utils.rs     |  57 ++++++
>  rust/kernel/virtio/virtqueue.rs | 314 +++++++++++++++++++++++++++++
>  samples/rust/Kconfig            |  15 ++
>  samples/rust/Makefile           |   1 +
>  samples/rust/rust_virtio_rtc.rs | 403 ++++++++++++++++++++++++++++++++++++++
>  13 files changed, 1309 insertions(+), 2 deletions(-)
> ---
> base-commit: 028ef9c96e96197026887c0f092424679298aae8
> change-id: 20260504-rust-virtio-8523b01dfdc2
> 
> Best regards,
> --
> Manos Pitsidianakis <manos@pitsidianak.is>
> 
> -- 
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd

