Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB96FBF
	for <virtio-dev@lists.linux.dev>; Tue,  1 Oct 2024 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747158; cv=none; b=PslbF27g3lFm1Xbz7NFv1QHjfTQp4w30YqUWVVPpO3C9AHFyNelMfjHHoV9cqMw9nWd2LcftaylA36ZJ7dXs2Nl118z7hCrfMW+XQF3p2ORo884fkhtKx2/rYOKezcXpUY65Izm8eeEra+cVWxjzQ0g7QFltnh/TBx/WfPCmGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747158; c=relaxed/simple;
	bh=MoiYmS+B6veEm5YqGvpYPbFstCPl8lhOw0M0GKJyfHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1UBFV5b8f6RgOi95JAppFFXxD0AOi1d90CdbWrO7zxyG0k2DBeZNHTJ7Dh4VS1TQKSi2ElKRx8570HcKZW9yv8T5/IAF1BkBso34gvV9QBn0jSclsqoNZUuYA+NwuoNq/UARBj4hFhZUWcI4saHIpefJUvCPm+P7lsUNM9T59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RpSlPJk8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RpSlPJk8"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a87c7c68dso62447866b.1
        for <virtio-dev@lists.linux.dev>; Mon, 30 Sep 2024 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727747154; x=1728351954; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/4Xqypuldl3uicp73KgGs/KFNhgtrfX7cdOdaweP/w=;
        b=RpSlPJk82Grp/pxY/idTYFnu0gyHF7t5zLitRCgvlv0sOtX3FCMtqU3qxEHSf/SliM
         ELGCYFuNYGVaXeXM2t5cJ5ZdufxLu3jIeFo5KpDM6kX2tKUewG0VOGNC8oBbOoahXrSM
         THzLAQRfllXqYSFDcONCnT0MF2ECwW6xbsP10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727747154; x=1728351954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/4Xqypuldl3uicp73KgGs/KFNhgtrfX7cdOdaweP/w=;
        b=InrJyY4MFCAx+IUCB15lKcUe6zTxfarUx6lRFmO7kvFjzolwkOBmQ3c956s1BY/Af1
         pCH3Y2VzPaWl0c0sPmmLpKNkZfPsk1lcc55qsqfr9KAojuS2tZvuqvzE7Qmx7IDHvXqn
         LDJxwi4KYmBK73mI/icijJGXgjomVmZIveD428HZtFlGtQyrSuArM62CSfCTmA2KWySM
         N8uYJkVOdXBW+8jzKfIXwBAS/LwaWc8szmnTT8L4qTY9Q14FnNlS3aNGOLkFa46f3wT4
         QNJsNfUWAXZHMsCgwtJkk2iwuyyJNYUaxnbP/TM0CSLjRMFmUYBNjyXXyoWFjgP4Nf+B
         09oA==
X-Forwarded-Encrypted: i=1; AJvYcCWpN9dqKqdd8Eh6QfcTguOjb/YNEpXSbU98eZJGZMGlvTv4x4EFSKz7uB6YVhwTTRJ3jCEp9Jr6bYdk@lists.linux.dev
X-Gm-Message-State: AOJu0Yzcmdu7KVqW3SKKhzcbUGOcSkxtMlxNsv/fhhaftx7HVU+0cRlT
	WBh1EedNfuSygynY/pnhluNFe7j84EG1LsIcT7HEWE+P7lCL0JNB+Bx7QVGVu/0oBIRXzJaK74k
	=
X-Google-Smtp-Source: AGHT+IGeE6RinMFzwj2hKrDGsGwOGJdIZzhxIaR+nQ72o1d4Ze4sWmcKjy3Ovxa7NFpnkuBU3HtEKA==
X-Received: by 2002:a17:907:3ea4:b0:a8a:9054:83af with SMTP id a640c23a62f3a-a93d8b60740mr485098666b.10.1727747153990;
        Mon, 30 Sep 2024 18:45:53 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27770b4sm609853066b.42.2024.09.30.18.45.52
        for <virtio-dev@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 18:45:52 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccfada422so2629773f8f.2
        for <virtio-dev@lists.linux.dev>; Mon, 30 Sep 2024 18:45:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWm4xkV4q60DJWeUWId2tmXLgVakUsiYvBDd7w9AjD9OcZ9xNXm6ejRCehk/f14lHUyhKAu3wikW8LX@lists.linux.dev
X-Received: by 2002:a05:6000:186b:b0:37c:d512:d427 with SMTP id
 ffacd0b85a97d-37cd5aba1efmr11432491f8f.35.1727747151318; Mon, 30 Sep 2024
 18:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925145228.27953-1-mgurtovoy@nvidia.com> <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com> <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
 <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com>
In-Reply-To: <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 30 Sep 2024 18:45:23 -0700
X-Gmail-Original-Message-ID: <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
Message-ID: <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[side note: I thought I subscribed to the virtio-dev list previously,
but the confirmation got lost in the spam filter initially, should be
fixed now]
On Fri, Sep 27, 2024 at 5:22=E2=80=AFPM Max Gurtovoy <mgurtovoy@nvidia.com>=
 wrote:
>
>
> On 27/09/2024 0:44, Daniel Verkamp wrote:
> > On Wed, Sep 25, 2024 at 4:42=E2=80=AFPM Max Gurtovoy <mgurtovoy@nvidia.=
com> wrote:
> >> Hi Daniel,
> >>
> >> On 25/09/2024 23:57, Daniel Verkamp wrote:
> >>> On Wed, Sep 25, 2024 at 8:05=E2=80=AFAM Max Gurtovoy <mgurtovoy@nvidi=
a.com> wrote:
> >>>
> >>> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit i=
s
> >>> set.
> >>>
> >>> The blk_size field represents the smallest addressable unit of data t=
hat
> >>> can be read from or written to the device. It is always a power of tw=
o
> >>> and typically ranges from 512 bytes to larger values such as 4 KB.
> >>>
> >>> I agree that this is what the blk_size field probably *should* have
> >>> meant (matching other storage protocols like ATA, SCSI, NVMe, ...),
> >>> but I believe rewriting the spec like this changes the meaning of the
> >>> blk_size field in an incompatible way.
> >> I believe that this is more of a clarification than a re-write.
> >>
> >>> Previously, blk_size was described as the "optimal" sector size, so i=
t
> >>> seems clear that the driver is still allowed to send requests that ar=
e
> >>> not aligned to blk_size ("awareness of the correct value can affect
> >>> performance" but no mention of correctness). A device may need to do
> >>> extra work to support this, of course, such as turning an unaligned
> >>> write into a read-modify-write sequence if the underlying storage
> >>> device doesn't support such an access directly, but such requests are
> >>> still valid. It's also perfectly fine for a driver to ignore
> >>> device-offered features like VIRTIO_BLK_F_BLK_SIZE and still operate
> >>> correctly.
> >> A device should report its block size (logical) using the VIRTIO_BLK_F=
_BLK_SIZE feature. For legacy devices that don't report this feature, Linux=
 assumes a 512-byte block size.
> > Sure, I agree with both points here.
>
> Great.
>
> So I guess we agree that blk_size =3D=3D logical_block_size.

Not necessarily (hence "should report" rather than "must report"). The
device is free to return any arbitrary size that it feels will improve
performance in blk_size (say, a RAID stripe size), even if it's not
the same as the logical block size of any backing storage.

> >> Drivers should not ignore this feature when it's offered by the device=
. It's crucial for correct operation IMO.
> > This is a "should", not a "must", though - adding a new MUST is a
> > breaking change.
>
> I can change it to 'SHOULD', but this modification has implications:
>
> 1. drivers that ignore the VIRTIO_BLK_F_BLK_SIZE feature will make
> assumptions about the logical block size.
>
> 2. Incorrect assumptions could lead to undefined behavior.

Where does the undefined behavior come from?

> I'm ok with 'SHOULD',  since it's a strong recommendation for drivers to
> negotiate and respect this feature when available.
>
> I'm not really familiar with drivers that ignore this feature so I won't
> argue here.
>
> >> The statement "driver is still allowed to send requests that are not a=
ligned to blk_size" needs explicit clarification in the spec.
> > It definitely would be better to have it written out explicitly, one
> > way or the other, no disagreement there.
> >
> >>  From my understanding of the spec, the driver is not allowed to do so=
 (otherwise error will be returned or the behavior is undefined).
> > This doesn't seem to follow from my reading of the spec. Otherwise,
> > phrases like "optimal sector size" and "can affect performance" would
> > not make sense (such a request would instead be described as
> > illegal/returning an error).
>
> Is it possible that certain parts of the spec could be improved ?
>
> Is it possible that certain implicit parts of the spec could be
> understood differently by various implementers or users?
>
> In reality "optimal block size that can effect performance" probably
> refers to logical vs. physical block size.

If this is the case, then it would be describing the
physical_block_exp and related fields from the VIRTIO_BLK_F_TOPOLOGY
feature, but it's referring to blk_size/VIRTIO_BLK_F_BLK_SIZE. Maybe
that's a mistake, but that's what the spec currently says (and has
said since at least the virtio-0.9.5 draft, which is the oldest one I
could dig up).

> This patch tries to make the spec clearer.
>
> >
> >> In Linux, the reported blk_size is used to set logical_block_size, whi=
le physical_block_exp is used to calculate the physical_block_size.
> > Sure, but this is describing the behavior of one driver
> > implementation, not really relevant to the meaning of the spec.
>
> It is relevant IMO.
>
> It's worth considering the historical context of the specification. To
> my understanding, the spec was initially derived from the Linux
> implementation, rather than the other way around.

The Linux implementation that inspired the spec originally is useful
when trying to understand the context, but if a current-day
implementor has to go read Linux code to understand how to interpret
the spec, then the spec is not clear enough and needs to be improved
(I would guess we agree on this). If the spec never matched reality,
then the spec is not useful, but I don't think that's the case here.

> This translation from implementation to specification could have
> introduced some inconsistencies or ambiguities.
>
> Also worth considering virtio-block devices that were implemented before
> this feature bit. The WG probably tried to maintain backward
> compatibility with these devices.

This feature bit and its description in the spec has existed for a
long time (since before virtio 1.0), so it's likely that many more
virtio-blk implementations have been written since this part of the
spec was added than before it.

> >> Regarding the specification statement: "This does not affect the units=
 used in the protocol (always 512 bytes)":
> >>
> >> This likely refers to how certain fields in the virtio-blk protocol ar=
e expressed, not the actual logical block size used for I/O operations. For=
 example: capacity reporting, max_discard_sectors and Other fields that are=
 expressed in 512 byte units.
> > The way the fields are expressed in the virtio-blk protocol is what is
> > relevant in the virtio spec. Even if a virtio-blk device is sending
> > requests to a physical SCSI/ATA/... device behind the scenes, it's the
> > job of that virtio-blk device implementation to handle the translation
> > and whatever mismatches there may be between the protocols.
>
> This is true.
>
> >
> > Particularly, the "sector" value in a virtio_blk_req used for
> > VIRTIO_BLK_T_IN/VIRTIO_BLK_T_OUT is always in 512-byte units,
> > regardless of what blk_size the device reports, and regardless of what
> > underlying physical media may be used.
> >
> >  From the virtio spec: "The sector number indicates the offset
> > (multiplied by 512) where the read or write is to occur."
> >
> > (This could probably use clarification that the "offset" is in bytes,
> > but it still seems pretty clear that it does not depend on blk_size.)
> >
> > So a request with sector =3D 1 always means an offset of 512 bytes from
> > the beginning of the block device, even if the advertised blk_size is
> > 4096.
>
> I appreciate your perspective, but I disagree with it.
>
> When a block device has a logical_block_size of 4K, it's not possible to
> perform read/write operations at arbitrary offsets like 512 bytes. The
> smallest addressable unit is the full 4K logical block in that case.

Maybe we disagree on the meaning of "addressable", then. What I assume
when I read "addressable" is "I can write the address" of such a
location (regardless of whether it's valid to submit a request using
this address). I can always write the address of the area of a
virtio-blk device that starts at an offset of 512 bytes, and that
address is always sector=3D1, even if the device advertises
blk_size=3D4096 and rejects unaligned I/O, so 512 is always the smallest
addressable unit. This is just like a CPU that has byte-addressable
memory but only allows aligned loads/stores - it's possible to write
an address like 0x123 and try to load a word from there, so that
location is addressable, even though it's not valid when trying to
load something larger than a byte from it.

I would not object to clarifying the wording, but it can't change the
meaning (if the smallest addressable unit was 4096 when blk_size=3D4096,
then sector=3D1 would mean 4096, but that's not how it works).

Rather than using wording like "smallest addressable unit", something
like "I/O request `sector` and data length must be a multiple of
`blk_size`" would accurately describe what you are trying to say (I
think), but this is still a breaking change in my opinion.

In theory, such a change could be introduced as a requirement tied to
a new feature bit (if the device advertises it and the driver acks it,
then I/O requests must be aligned, or something like that), but since
it would be a new, optional feature, I don't know how useful it would
be.

> This is a fundamental principle of block device operations, not just an
> optimization.

For normal block devices that speak ATA or SCSI or NVMe command sets,
yes, I agree - but this is not how virtio-blk was defined. And again,
I agree that it was probably a mistake to define virtio-blk in a way
that is different from all other normal block device command sets, but
that's the way it has been described in the spec since at least 2012.

> Also IO granularity.
>
> I believe it's important to ensure that the specification accurately
> reflects these fundamental block device principles.
>
> I believe that the reason that the "sector" is multiplication of 512 is
> to maintain backward compatibility, and not to allow breaking these
> fundamental principles.

Yes, it is exactly this backward compatibility that I'm concerned with
- old drivers (or drivers that ignore blk_size, which they are clearly
allowed to do per my reading of the spec) must still work correctly
with devices written against new versions of the spec.

> > This is different from (e.g.) a SCSI READ where the logical block
> > address is in units of the block length returned by READ CAPACITY, so
> > it is impossible to send a request that is not block size aligned.
>
> IMO, it is impossible for virtio block device and any other block device
> as well.

I don't understand how it would be impossible; inconvenient, sure, but
definitely possible.

If a device receives a VIRTIO_BLK_T_IN request that is not aligned to
its preferred blk_size, it can read the minimum blk_size-aligned
region around the request into an intermediate buffer and copy only
the requested parts into the virtio buffer.

If a device receives a VIRTIO_BLK_T_OUT request that is not aligned to
its preferred blk_size, it can read the aligned region into a
temporary buffer (as before), copy the data from the virtio buffer on
top, and perform the aligned write.

If a device implementation can't afford to buffer data (such as a
hardware device with minimal on-board memory), then maybe it would be
reasonable for that device implementation to choose to return an error
for unaligned I/O, but it must not fail in a way that would cause
undefined behavior like corrupting parts of the disk.

> > [...]
> >>>> diff --git a/device-types/blk/description.tex b/device-types/blk/des=
cription.tex
> >>>> index 2712ada..88a7591 100644
> >>>> --- a/device-types/blk/description.tex
> >>>> +++ b/device-types/blk/description.tex
> >>>> @@ -3,7 +3,10 @@ \section{Block Device}\label{sec:Device Types / Blo=
ck Device}
> >>>>   The virtio block device is a simple virtual block device (ie.
> >>>>   disk). Read and write requests (and other exotic requests) are
> >>>>   placed in one of its queues, and serviced (probably out of order) =
by the
> >>>> -device except where noted.
> >>>> +device except where noted. Each block device consists of a sequence=
 of logical
> >>>> +blocks. A logical block represents the smallest addressable unit of=
 data that
> >>>> +can be read from or written to the device. The logical block size i=
s always a
> >>>> +power of two. Logical block sizes may be 512 bytes, 1KB, 2KB, 4KB, =
8KB, etc.
> >>> Does this imply that a device may return an error for a request where
> >>> the sector or num_sectors fields are not aligned to the blk_size? If
> >>> so, it should be called out as a more explicit normative requirement,
> >>> but that would definitely be an incompatible change.
> >> As mentioned, the logical block size, such as 512 bytes, defines the s=
mallest addressable unit for I/O operations on the storage device.
> >> This has important implications for I/O requests:
> >> 1. Minimum I/O size: You cannot send I/O requests smaller than the log=
ical block size. For example, with a 512-byte logical block size, requests =
of 128 bytes are not valid.
> > 128-byte requests are not valid, certainly, but that is already
> > covered by the wording in the spec ("in multiples of 512 bytes" in the
> > VIRTIO_BLK_T_IN/VIRTIO_BLK_T_OUT description, and "The length of data
> > MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN and
> > VIRTIO_BLK_T_OUT requests" in the driver requirements).
>
> I guess I should have given 4KB logical block size as a better example.
>
> In case logical block size is 4KB, the minimum IO size is 4KB and not 512=
.
>
> Agreed ?

In the case of SCSI or whatever, absolutely.

virtio-blk doesn't have a concept of logical block size today, only
the existing blk_size field, which I argue is not necessarily
equivalent.

(I have noticed that the virtio_blk_topology fields are defined in
terms of "logical blocks", which I feel is a mistake - either these
should be described in terms of blk_size, or the blk_size field needs
to be redefined to explicitly mean "logical block size" as in your
patch.)

> >> 2. I/O alignment: All I/O requests must be aligned to the logical bloc=
k size. This means the target start address (on the media device) of the I/=
O must be a multiple of the logical block size (the expressed units in the =
spec are not relevant).
> > Unless there is a change to the spec (like this proposed patch), I
> > don't think this is required. I suppose a device that can't manage to
> > perform a misaligned I/O could choose to deny such requests and return
> > VIRTIO_BLK_S_IOERR, but this is not explicitly allowed or denied by
> > the current spec.
>
> This is a clarification of the existing specification, not a change.
>
> I believe I've identified the main point of disagreement regarding this
> patch:
>
> I believe that I/O operations to storage block devices MUST be aligned
> to the logical block size. In the other hand, you believe it is just a
> recommendation for virtio block device.
>
> Maybe let's see what others think as well ?
>
> Stefan ?

I agree that it would be useful to have more input from other
interested parties.

> >> 3. I/O size granularity: The size of I/O requests must be a multiple o=
f the logical block size. For a 512-byte logical block size, valid I/O size=
s would be 512 bytes, 1024 bytes, 1536 bytes, and so on.
> > Same as point 1 above, the only requirement (that I can see, anyway)
> > is that the I/O request has to be a multiple of 512 bytes.
>
> Do you think that for logical block size of 4k one can send IO of 1K to
> such device and succeed ?

For a virtio-blk device, yes (assuming "such a device" is a virtio-blk
device implementation and we substitute blk_size for "logical block
size").

> >>> The "smallest addressable unit" wording is also more confusing than
> >>> clarifying here, since in virtio-blk, the "smallest addressable unit"
> >>> is always 512 bytes, regardless of blk_size (even if a change like
> >>> this would enforce limits on the sector values that would actually be
> >>> allowed, it would still be possible to create a request that refers t=
o
> >>> a smaller unit than blk_size, unlike other storage protocols where
> >>> logical block size changes the multiplier of the address, making it
> >>> impossible to address smaller units).
> >> Can you please point me to the place in spec that explicitly say that =
"in virtio-blk, the smallest addressable unit is always 512 bytes, regardle=
ss of blk_size" ?
> > The description of struct virtio_blk_req's sector field:
> > "The sector number indicates the offset (multiplied by 512) where the
> > read or write is to occur."
> >
> > Unless we have different definitions of "smallest addressable unit",
> > that seems pretty clear. It is always possible to address a part of
> > the disk in 512-byte multiples (e.g. sectors 1 through 3) even when
> > the blk_size is larger than 512. Maybe those requests won't succeed,
> > but it is always possible to describe a region of the block device
> > with an address that is not a multiple of blk_size.
>
> It doesn't say anything explicit about IO alignment and granularity.
>
>
> >
> >> I didn't find it in the spec and I don't agree with this call if it is=
 implicit.
> > I agree it should be clarified. The current wording requires too much
> > reading between the lines.
> >
> >> The implementation of the Linux kernel driver isn't implemented in thi=
s manner as well.
> > When filling the sector field, the Linux virtio-blk driver uses the
> > value of blk_rq_pos(), which is also always in units of 512 bytes, as
> > far as I can tell (it returns sector_t, which is in units of 512 bytes
> > per the definition in include/linux/blk_types.h).
>
> Ignoring the units for the discussion, can it ever be unaligned to the
> logical block size?

The Linux driver will always request I/O that is aligned to the
blk_size (if the device reports one), yes - but that's one driver's
choice. Other drivers (which were written against the spec, not
"whatever the Linux driver does") may operate differently.

> > [...]
> >>>> @@ -228,7 +234,7 @@ \subsection{Device Initialization}\label{sec:Dev=
ice Types / Block Device / Devic
> >>>>   \item The device size can be read from \field{capacity}.
> >>>>
> >>>>   \item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
> >>>> -  \field{blk_size} can be read to determine the optimal sector size
> >>>> +  \field{blk_size} can be read to determine the logical block size
> >>>>     for the driver to use. This does not affect the units used in
> >>>>     the protocol (always 512 bytes), but awareness of the correct
> >>>>     value can affect performance.
> >>>> @@ -282,6 +288,12 @@ \subsection{Device Initialization}\label{sec:De=
vice Types / Block Device / Devic
> >>>>
> >>>>   \drivernormative{\subsubsection}{Device Initialization}{Device Typ=
es / Block Device / Device Initialization}
> >>>>
> >>>> +Drivers MUST negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offe=
red by the
> >>>> +device.
> >>> Why is this a MUST? This is also an incompatible change since there
> >>> was no such requirement before, and drivers are free to ignore
> >>> features they don't care about.
> >> I can say SHOULD, but then the driver that is ignoring this feature ma=
y guess/assume the logical block size and it can be wrong.
> >>
> >> This may lead to an undefined behavior.
> > Unless the spec is changed, if a device can't correctly handle
> > non-blk_size-aligned requests, this seems like it would be a device
> > bug ("undefined behavior") or at least non-spec-derived limitation
> > (returning an error would not be undefined, but also probably wouldn't
> > result in a working system).
>
> Again, this is a clarification of the existing specification, not a chang=
e.
>
> IMO, storage block device implementations should be able to assume that
> I/O requests from drivers are aligned to the logical block size. If a
> device receives misaligned I/O requests, it might be appropriate for the
> device to fail these requests. It is not a device "bug" IMO.
>
> I'm curious if you've encountered any actual implementations where
> drivers send non-block-size-aligned requests to block devices. I never
> saw such implementation.

I don't know of any real-world implementations like this, but the
point of the spec is to allow interoperability without having to know
about every implementation.

> Sounds like a theoretical objection.
>
> IMO, the specification could benefit from explicitly stating this
> alignment principal, which would guide both device and driver
> implementations.
>
> I believe that this patch is clarifying important points and would lead
> to more robust definition.

From my point of view, it would be fine to clarify a few things:
- blk_size should (not must) be the logical block size of the
underlying storage device
- data should (not must) be a multiple of blk_size for best performance

And maybe:
- devices may choose to return IOERR if a driver submits an I/O
request that does not conform to the above recommendations (but this
conflicts with the "performance"-related wording that exists now)

> > Certainly it would be preferable for the driver to send aligned
> > requests, but the existing wording seems to cover that pretty well
> > already.
> >
> > Thanks,
> > -- Daniel
