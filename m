Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0D3E16AD
	for <virtio-dev@lists.linux.dev>; Mon, 18 May 2026 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091957; cv=pass; b=u7++cLDbb9ZxKm42ZwndyIb+++CMzbGE4pZ+DochHyPMEIa16sJBu3HrIUUmGxTWgHO1GPTAZlQDD5eBUn15Q6Y76VhZKLc6dtYU+5ZZbOXbivjLf/SzM79SJN2gbCCm5nza09ACq+r+wxbfhAhl6plNzjfaleSCA9Oj+vLBj34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091957; c=relaxed/simple;
	bh=Tuf2X6pJHjFu8GE2uZkH0KR6TOeYXFGmlacyq2isFio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3z6En+MeG6tTx+o3QybfV6xGtnQwRFQmkggQI3gMFcpiKtvGWdLUF6VvExiwgomSmcrY7vBBM2gPsl9ryOKXCYiGy/I3ZVI+ZOKyj0iA6SY/Cgmc6DLBYHhuZ7fIxfZM5Ueae9uJ3kVhUfOwHt8eWEVaGsVYEZchvSgIX4dWog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yc7RXCtZ; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yc7RXCtZ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d73422431so1218590f8f.2
        for <virtio-dev@lists.linux.dev>; Mon, 18 May 2026 01:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779091953; cv=none;
        d=google.com; s=arc-20240605;
        b=KSSrwa6YtOOU86YvAxovxb+rAdX90F1W9MzjgvstEOm51xbEvI34hvRc9zKEtaSrK0
         sNpqrXqQH0gRQZo/IctGIgGdcMmDFyghlSBZXX7XJGkI4WRy4H1I2wQbzRF5vwULfNys
         ZL/CobJQ5gqnnnLRyodHczcEDypfqbzQvFnEKMD1yPOW7j3X4DDRK4s9JueyGTxSykNJ
         nttZOm2d4ut/ypGHB5VCcMgGbBi4pgD0VsEsFlkcgvjDvMhfkqa3OfKUMazn7G1vceFQ
         KMQ3BKr9x9JZVsP8KDNoVqJaEjgZroLDwOm2SekfRKm5pTYqFGBG+ZvQq1yEaywZu0BK
         BOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F5oZ23VmgQBTLa9PoADUF7D5cvJE4/DZ3MmYqtO5ARQ=;
        fh=gwIDPqvkJUrznlLXWAVd3pqvM1RkI8yvBa1HPjcEsGA=;
        b=Kn+Hzifwwd+LdDadYJPVWmnWs2Z3yOkju7x5PsGA+V0FKvo6897tRRS8XO7NDpr1rA
         B0ijbgh3pbjood/7AXOio/X8ffTLx2z9lcBtXxIlBTXQ0gUP1QjXXddeHC2EP3YyvWpN
         QM/PPKbATEco2fa3Ih/PU1m2J8Tgdz+c0BhH6M3Sbxu7TIIkAQvlI1Ejy7LyUxATweih
         7Za2taUB/2LM9zQyJn4xB0+RDTgkcoAqcXmRbqgXMonTKjdwgQy7mhuiEW0a/UPzQzWe
         1903HxtMZxGxJ6Xw8myIjCEgaOT7P89+vre+AkFhAiKsiGLkDb7KgNzeZOvvQv1hWgXN
         LywQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779091953; x=1779696753; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5oZ23VmgQBTLa9PoADUF7D5cvJE4/DZ3MmYqtO5ARQ=;
        b=yc7RXCtZSxsRLotqt9kD7/P9WzYtyd19ld6TaIEyihulFguUZPCA6vOtyGH+xKJRxp
         nAxgMXiOhoc2IwNMTU8JZ61oKXpOr73BjTswByb2grwMl8iZobNOTSaLgoJffkwsekNe
         /i9zxkzhh8oe7JYFUYChdBRDP7E+5joh21nXjwaXV/gkixGO1zu3Tz2a452Ct/UsJfdt
         AnVOXBvSofcROihPqEDWr5xF+d/S+wx4oYGue1uK1DVmd4T9IfB2KwNIv1ku8p1z5RfC
         i0Q3HFrjXVR0WL8UJGUt38n9J1ZQjNAduf60iDLurn51MwlNuy/ebkgs6yONLRoVB48Z
         ifDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779091953; x=1779696753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F5oZ23VmgQBTLa9PoADUF7D5cvJE4/DZ3MmYqtO5ARQ=;
        b=evnDwfK8fwNXLStuKXMB8kJTjcQODuQyNygtS5B6YE8K9uGLKDRJ25D5LAyh5tm1Cl
         A2RdxQbJ21LhQFbmxfrtW+CPFgDKPmieiboPgEEpmuTZ8hOm3QLM/oCOBsma5hSSU3nR
         5AeHWJaX/1d0MrHBNrmLzrzX2IuGvJKmsA/aNIRCq0KbgpI8s+hUvKBsnnKZBsGClFKi
         IVaDqkGUgP71EV6tAAyKIZwxWtDw+mqosy/2jGmD4ebkwowC11Kx1f7zA1c2EooJsw9V
         xgyz9WEX4t338kEIDecjT5HeItUk9Pi40nHblWpHNkKpHYqXS6TNfSRfgNRLWXtZVBvu
         rq1g==
X-Gm-Message-State: AOJu0YzM9qGg5LdEFbRKsMSuAp64Ntzr3RDe2ZA7vKcNl3sqsr3TxTu7
	n/t9n38yNRC1DCc3x6QHvZaTR5CGdWAP04hIpYU6uDAOCngjHR8UZI5VoHkqAbVk+aAVAYor+vF
	QPQjzf9DQRFGZc4MYNwthTQJIfjBMOt4NtNqVu8hvJFXCvXjnvsxprqgW3w==
X-Gm-Gg: Acq92OFyM6zTG9K0dX5zinUK43WLCxC5g8rUNuHziyKqAN08wAC1gtDdTi8zAit8pQG
	8/jGVu0m5ofLj9jwA4PcYGeKBks5/j6uSNvR6oyjCBR8760bDRyNExxZ8yjIolxUI7dHjoqYRML
	/4V9E+1ckGWCFff29PEeedh+TlbqdSJwyAtb2IN3/6EbrxzC1/0wspBbTJPMMtARwd0zaIOmObF
	c3G1R6TzGKf84rUHA0a4H8A6KPTh0yjuGroErAhd5fnblouV8OoVCX/cxoAOE5KDN7uP4+nREos
	KusAXi+T5lJlRmlAqRYSIagfajj9/vRt9D8l9x3/s6yDTCYzNQ==
X-Received: by 2002:a05:6000:1b85:b0:45e:739b:274c with SMTP id
 ffacd0b85a97d-45e739b281emr6906687f8f.24.1779091953051; Mon, 18 May 2026
 01:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
In-Reply-To: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 18 May 2026 11:12:06 +0300
X-Gm-Features: AVHnY4JrNu58LXZC9dOJNk9fia5VaIRLkVz7xx93Q5VAUOhcwGxPJmxkIKBSOJA
Message-ID: <CAAjaMXaOm=sOjO4ksM-PcOf4wqez9+ePBdv9U7prHiVaCx7-+Q@mail.gmail.com>
Subject: Rust virtio drivers in Linux
To: VirtIO Dev List <virtio-dev@lists.linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, manos@pitsidianak.is
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

I have a new device type proposal for the virtio spec I hope to
publish to virtio-comment soon and I have a reference C driver
implementation for Linux. However I would prefer to implement the
driver in Rust, and should it be accepted upstream, abandon the C
driver out-of-tree.

In preparation for that, I wrote bindings for the virtio subsystem and
sent them to LKML. I had forgotten to CC virtio-dev.

The RFC I sent 2 weeks ago has a sample virtio-rtc driver that doesn't
register itself to the rtc subsystem. Since then I wrote a virtio-rng
driver instead that is fully equivalent to the C driver. I haven't
sent it yet because my last revision did not receive any comments yet.
My WIP tree is https://github.com/epilys/linux/tree/rust-virtio

I'd like to hear any feedback and suggestions, especially from the
kernel virtio and Rust maintainers.

Note: An issue with virtio drivers is that they require bindings both
for virtio and the device subsystem. For example I had to write hwrng
bindings for the virtio-rng driver. Does this require more
co-operation from kernel maintainers in order to get things merged?

Miguel: WDYT?

Thanks in advance!

---------- Forwarded message ---------
From: Manos Pitsidianakis <manos@pitsidianak.is>
Date: Sun, May 10, 2026 at 4:38=E2=80=AFPM
Subject: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Hilber
<peter.hilber@oss.qualcomm.com>, Stefano Garzarella
<sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Viresh
Kumar <viresh.kumar@linaro.org>, Michael S. Tsirkin <mst@redhat.com>,
Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Bj=C3=B6rn Roy
Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
Krummrich <dakr@kernel.org>, Daniel Almeida
<daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
Jason Wang <jasowang@redhat.com>, Xuan Zhuo
<xuanzhuo@linux.alibaba.com>, Eugenio P=C3=A9rez <eperezma@redhat.com>,
<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
Manos Pitsidianakis <manos@pitsidianak.is>


Hi all, this RFC series adds Rust bindings for Virtio drivers
(frontends in virtio parlance).

As a PoC, it also adds a sample virtio-rtc driver which performs
capability discovery through the virtqueue without registering any clock.

Before I send a cleaned-up non-RFC I would like some initial feedback
(i.e. is it something the upstream wants?)

This was tested with the rust-vmm vhost-device-rtc device backend that I
wrote[^0]:

[^0]: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rtc

Instructions:

  Run the daemon in a separate terminal:

  $ cargo run --bin vhost-device-rtc -- -s /tmp/rtc.sock

  Then run the VM:

  $ qemu-system-aarch64 \
    -machine type=3Dvirt,virtualization=3Doff,acpi=3Don \
    -cpu host \
    -smp 8 \
    -accel kvm \
    -drive if=3Dvirtio,format=3Dqcow2,file=3D./debian-13-nocloud-arm64-dail=
y.qcow2 \
    -device virtio-net-pci,netdev=3Dunet \
    -device virtio-scsi-pci \
    -serial mon:stdio \
    -m 8192 \
    -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
    -numa node,memdev=3Dmem \
    -display none \
    -vga none \
    -kernel /path/to/linux/build/arch/arm64/boot/Image \
    -device vhost-user-test-device,chardev=3Drtc,id=3Drtc,virtio-id=3D17,nu=
m_vqs=3D2,vq_size=3D1024
\
    -chardev socket,path=3D/tmp/rtc.sock,id=3Drtc \
    ...

  Example output:
    [    1.105238] rust_virtio_rtc: Probe Rust virtio driver sample.
    [    1.105645] rust_virtio_rtc: Found 1 vqs.
    [    1.136050] rust_virtio_rtc: process_requestq got buf 16 bytes
    [    1.136125] rust_virtio_rtc: Got response! Ok(RespCfg { head:
ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
num_clocks: Le16(3), reserved: [0, 0, 0, 0, 0, 0] })
    [    1.136701] rust_virtio_rtc: Got response! Ok(RespClockCap {
head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
clock_type: 3, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0,
0, 0] })
    [    1.136724] rust_virtio_rtc virtio0: cannot expose clock 0
(type 3, variant 0, flags 0) to userspace
    [    1.137259] rust_virtio_rtc: Got response! Ok(RespRead { head:
ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
clock_reading: Le64(1777890485031060388) })
    [    1.137277] rust_virtio_rtc: #0 clock reading =3D 177789048503106038=
8
    [    1.137749] rust_virtio_rtc: Got response! Ok(RespClockCap {
head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
clock_type: 1, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0,
0, 0] })
    [    1.137769] rust_virtio_rtc virtio0: cannot expose clock 1
(type 1, variant 0, flags 0) to userspace
    [    1.138247] rust_virtio_rtc: Got response! Ok(RespRead { head:
ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
clock_reading: Le64(1777890485032086075) })
    [    1.138264] rust_virtio_rtc: #1 clock reading =3D 177789048503208607=
5
    [    1.138730] rust_virtio_rtc: Got response! Ok(RespClockCap {
head: ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
clock_type: 2, leap_second_smearing: 0, flags: 0, reserved: [0, 0, 0,
0, 0] })
    [    1.138751] rust_virtio_rtc virtio0: cannot expose clock 2
(type 2, variant 0, flags 0) to userspace
    [    1.139253] rust_virtio_rtc: Got response! Ok(RespRead { head:
ReqHead { msg_type: Le16(0), reserved: [0, 0, 0, 0, 0, 0] },
clock_reading: Le64(338567896865557) })
    [    1.139270] rust_virtio_rtc: #2 clock reading =3D 338567896865557

Concerns - Notes - TODOs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- Virtqueue lifetimes don't neatly apply to Rust as expected, so a lot
  of times we have to go through unsafe pointer dereferences (though
  which are guaranteed by Virtio subsystem to be valid, for example when
  a callback is called with the vq argument). There's a potential for
  misuse and definitely could use better thinking.
- `struct virtio_device` is not reference-counted like other implemented
  device types in rust/kernel. Maybe we need to change C API first to
  make them reference counted, assuming this doesn't break anything?
- The sample driver obviously conflicts with the C implementation, so
  this would either need to move out of samples/ or figure out some way
  to handle this in kbuild.
- kernel::virtio module and its types need a few rustdoc examples that I
  will add in followup series
- Note that the registration of RTC clocks etc in the sample driver is
  not done, I'm putting it off until I receive some feedback first. The
  sample driver otherwise does send and receive data from the virtqueue
  as a PoC.

PS: No LLMs used so any mistakes and goofs are solely written by me.

Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
---
Changes in v3:
- Removed unused methods from virtio API
- Clean up how scattergather lists are added to virtqueues by using
  owned SGTables only, and make the API safe(r)
- Add RAII cleanup for find_vqs return value that calls del_vqs
- Reset device after remove callback
- Significantly clean up sample driver as a result of the other cleanups
- Link to v2: https://lore.kernel.org/r/20260509-rust-virtio-v2-0-c1e30ec2b=
d21@pitsidianak.is

Changes in v2:
- Move helper ifdefs to helper file (thanks Alice)
- Changed CONFIG checks to IS_ENABLED to allow for CONFIG_VIRTIO=3Dm
- Split all use imports to one item per line according to style guide
- Fixed wait_for_completion_interruptible*() rustdocs
- Use Jiffy type alias in wait_for_completion_interruptible_timeout()
- Pepper and salt #[inline]s wherever appropriate as per style guide
- Split probe() into probe() and init() to allow cleaning up if init
  fails
- Remove unnecessary Send and Sync unsafe impls for
  kernel::virtio::Device
- Remove unnecessary LeSize and BeSize
- Accept Option<_> for virtqueue callback when creating a VirtqueueInfo
- Made all vq buffer adding operations unsafe
- Use AtomicU16 instead of Cell<u16> for sample virtio driver
- Fix RespHead field types in sample virtio driver
- Fix response error checking in sample virtio driver
- Change some device contexts in method signatures
- Link to v1: https://lore.kernel.org/r/20260505-rust-virtio-v1-0-956338390=
9e4@pitsidianak.is

---
Manos Pitsidianakis (6):
      rust/bindings: generate virtio bindings
      rust/helpers: add virtio.c
      rust/kernel/device: return parent at same context
      rust: add virtio module
      rust: impl interruptible waits for Completion
      samples/rust: Add sample virtio-rtc driver [WIP]

 MAINTAINERS                     |   9 +
 rust/bindings/bindings_helper.h |   5 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/virtio.c           |  37 ++++
 rust/kernel/device.rs           |   2 +-
 rust/kernel/lib.rs              |   2 +
 rust/kernel/sync/completion.rs  |  42 +++-
 rust/kernel/virtio.rs           | 423 ++++++++++++++++++++++++++++++++++++=
++++
 rust/kernel/virtio/utils.rs     |  57 ++++++
 rust/kernel/virtio/virtqueue.rs | 314 +++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  15 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_virtio_rtc.rs | 403 ++++++++++++++++++++++++++++++++++++=
++
 13 files changed, 1309 insertions(+), 2 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260504-rust-virtio-8523b01dfdc2

Best regards,
--
Manos Pitsidianakis <manos@pitsidianak.is>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd
