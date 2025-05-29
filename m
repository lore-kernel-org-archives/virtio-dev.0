Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC121C18E
	for <virtio-dev@lists.linux.dev>; Thu, 29 May 2025 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748554461; cv=none; b=sD6BQIyQB9O1bUYhEpVQ9/gpeqz/B6ySRSmgi02jgbKlBiDgyZZ7+16/A76RA1asNjEX8vAP+inaL4AvsNrdjKvcDMEL5TdcFbbgz1Iq0QYwXc/rFFpwi7WFHxoSIz6wANxec7TUu/k20C9+rap5nzEQf8hHgR1PJxfxNpu5m5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748554461; c=relaxed/simple;
	bh=kfCpFTFrbdTQIknywtp9Sk0BnfT20KTeofl1Pd7JlBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Sbv7MvoH5UEU/VECBeWemft2IrfnMEMn7vk85oeWF1pulV4jmaKJsue7Kkziqj25l943GW4uT7bgOqZ6fEcFHZ94iRsqAEaNXrsp5BKoK0b3E6Got3HfhtLmZVTslmqhSzwwwaY7opKmPT+s7Kh3Gfx+zwqW19wQK6Wq3d4/Q64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQXTjyls; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQXTjyls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748554458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/Hh/yH90kbYQevGGK0fC8DG2lqe7PbfAUHkaT3/my4=;
	b=VQXTjyls6OADqUPaI8yQBJHyxxGm83y0kPdO8DI4BcnrAxdBgQTf5JTI8ytxCk7v5wFEaU
	+bp+m3Fb9PgzrRwww7Me9xTyJ6IcXLO8ssvoBikileaiZjEytuEeK3FKEMu1eapSu9/0eg
	go/tbQ/onKByFfqa8uS3PVyekGL7Mw4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-QXj0PDb1POyhH2VdXYfcOA-1; Thu, 29 May 2025 17:34:17 -0400
X-MC-Unique: QXj0PDb1POyhH2VdXYfcOA-1
X-Mimecast-MFC-AGG-ID: QXj0PDb1POyhH2VdXYfcOA_1748554456
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d57a0641so4190225e9.3
        for <virtio-dev@lists.linux.dev>; Thu, 29 May 2025 14:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748554456; x=1749159256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/Hh/yH90kbYQevGGK0fC8DG2lqe7PbfAUHkaT3/my4=;
        b=sStWqKPFMLyqHl8DYfYjWp3avhcDGMeBwEqaVm2OakQ9olboMRZR97suXLqBsBMW3T
         aKFRKhPqC0lQB494XJcoQjK3Im9yUwxfLrhAVm/oeZxAbN7BT/TMmKwMf44E/Y8t3g98
         /bs7+2HTO+TSQKXqVsroFY50NnDXa+yQHDGyozdZ4R36cAfYB84q7+FrCuq0wxZ8czmR
         MLWjr5cZFGNPIiNWQ7rBsN670ZK3rNjOi9inpGvOxG2ibuOqEU9yA5Nuo0sNgIWB6A02
         mioh8BL/hGkIWDe4SLCsMChpc7S5WsvkCEVZa40VbThyK+rdpg0dvvcxRtdgdtAsq7+k
         60fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX444or1V8EhdQz5ZZNcvXjBxJZ6kuXFUFQ+GOGUUv09539j7Qwvvy0NbwHDXtkK+M1wiBPYILOO/Qf@lists.linux.dev
X-Gm-Message-State: AOJu0YztEkg8t5tuvTVdq5ffMFogSNhfCKuwJAIQDfa85adjY90+6fhx
	d0bC/vs/sdJcpihdFb5A7fPSh5STLi+mPSuIA7tpORS5JQ/BmIUytlGL4kb3mwgvfSNT4956/0N
	0lv+ugvQ5L10DxGtkESgexGRXunZG+9l8spM2BzJvcdJ/ibsH8DrVHXs8WdCTazI=
X-Gm-Gg: ASbGncsDCPzllfF5bEYMe916H/IASQCkaM93fQc54sJqKqkh/1PGSgTpwPe69KEzSOH
	Ije5UyeHxlx2JyM+NwNcignv2gPwAMEMZW+hHcyK6E6TDjCkf4hLPP3/jwd82Vxd9+D1HubOEUR
	R+xYvFPBk42TEE+vQbAK2G39LtgD0mZZGm1Pn8GO/sS5gNBl6+f9AyckWu7IuxCwphbLJ3ujJY9
	V3VNSBS+10FmifLwoDb9ZYXpujg9rv1UqI93dFeL0neMw9QrDGc94YOsL28OAO7w32+zX91JyxK
	7s1buw==
X-Received: by 2002:a05:600c:474e:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-450d64e01d8mr13882255e9.10.1748554456019;
        Thu, 29 May 2025 14:34:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIvLvhcx1A90sZoU0iqK7W1Ia+ZBkZGiQMs7VA3Nq4z0nk3Itzi5JsQJs1pDj1Oxku+V729A==
X-Received: by 2002:a05:600c:474e:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-450d64e01d8mr13882065e9.10.1748554455579;
        Thu, 29 May 2025 14:34:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4504e245428sm50678475e9.1.2025.05.29.14.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 14:34:13 -0700 (PDT)
Date: Thu, 29 May 2025 17:34:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: virtio-comment@lists.linux.dev,
	VirtIO Dev List <virtio-dev@lists.linux.dev>,
	Bill Mills <bill.mills@linaro.org>,
	David Hildenbrand <david@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sergio Lopez <slp@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: Central repo for VirtIO conformance tests?
Message-ID: <20250529172335-mutt-send-email-mst@kernel.org>
References: <87semtpjrt.fsf@draig.linaro.org>
 <CAAjaMXZgeNpExoiDKr3RRms_voE0bU9G033gOmawDqsFbGj2Gw@mail.gmail.com>
 <20250519034810-mutt-send-email-mst@kernel.org>
 <CAAjaMXafNUEk6jAkh-9iY6JNSKzawM+GRJAHAxZ6X9dkwhMyfg@mail.gmail.com>
 <20250519041030-mutt-send-email-mst@kernel.org>
 <CAAjaMXZZX+i86U4_N1_8+czc2kcWP3=NUgLjT8BMemCYBD6uUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAjaMXZZX+i86U4_N1_8+czc2kcWP3=NUgLjT8BMemCYBD6uUw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s4cYd0FfiBXD5Arh5Shubb439ma16nsJBvaNE_ZryPg_1748554456
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 19, 2025 at 11:18:36AM +0300, Manos Pitsidianakis wrote:
> On Mon, May 19, 2025 at 11:15 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, May 19, 2025 at 11:03:43AM +0300, Manos Pitsidianakis wrote:
> > > Hello Michael, thanks for the reply,
> > >
> > > On Mon, May 19, 2025 at 10:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, May 19, 2025 at 10:43:33AM +0300, Manos Pitsidianakis wrote:
> > > > > Pinging this thread to ask the OASIS people: Would it be possible to
> > > > > host a software project (this testsuite) under OASIS but with a
> > > > > lighter contribution process? We expect everyone to be contributing to
> > > > > them, from open source/proprietary hypervisor developers, to kernel/OS
> > > > > developers, hobbyists and professionals alike. So I think a low
> > > > > barrier of entry would be reasonable here.
> > > >
> > > > Take a look here pls:
> > > > https://www.oasis-open.org/open-repositories/#licensingRules
> > > >
> > > >
> > > >
> > > > > Seeing as a test suite is essentially tied to the published VIRTIO
> > > > > spec itself it also makes it a good fit semantically. Having a suite
> > > > > with multiple VIRTIO implementations including slim images with Linux
> > > > > would also give a wider frame of reference for downstream consumers of
> > > > > the spec. Currently, the Linux kernel is the de facto (because it's
> > > > > also open source) VIRTIO implementation on the frontend side and
> > > > > oftentimes we end up looking at what Linux does to implement backends.
> > > > >
> > > > > We'd like to potentially:
> > > > >
> > > > > - Expand the array of rootfs images with more Linux userspace tests
> > > > > for more devices
> > > > > - Expand the array of rootfs images with other open source OSes as
> > > > > they gain VIRTIO functionalities
> > > > > - Implement missing VIRTIO spec features in our unikernel test and
> > > > > also exercise realistic but basic VIRTIO command use scenarios for
> > > > > more devices
> > > > > - (This is on my personal wishlist) write a VIRTIO fuzzer framework,
> > > > > similar in spirit to Google's syzkaller project (unsupervised
> > > > > coverage-guided kernel fuzzer)
> > > > > - As a stretch goal, provide a reference test runner framework to run
> > > > > the images with QEMU and rust-vmm vhost-user backends for people to
> > > > > adapt to their setups.
> > > > >
> > > > > PS: The git repositories Alex linked are temporarily inaccessible due
> > > > > to internal unrelated issues, and will be public again.
> > > >
> > > >
> > > > At the moment, from the above link, and if you want it tied to OASIS
> > > > open repositories, it has to be one of:
> > > >
> > > > BSD-3-Clause License (which shall apply if the TC makes no license selection in its approval action); Apache License v 2.0; CC-BY 2.0; CC-BY 4.0; Eclipse Public License v 1.0.
> > >
> > > OK that's doable and completely reasonable.
> > >
> > > > I am not a lawyer, but can full OS images we licensed under one of
> > > > these? If not, you are better off creating the repository itself outside
> > > > the confines of OASIS.
> > >
> > > We'd be hosting essentially build recipes for the images, for tests
> > > where we use other people's code. The build recipes would have the
> > > same license.
> > >
> > > If I understand the CLA requirement correctly, even if the
> > > contribution is merged by a maintainer who has signed the CLA, the
> > > original contributor who has no write access to the repository, has to
> > > sign the CLA as well?
> >
> >
> > I think is would be the OASIS equivalent of the Linux DCO:
> >         Each person making a repo contribution must be bound to the terms of the
> >         CLA, by obtaining their signature (which may be an equivalent electronic
> >         assent)
> 
> So just a Signed-off-by? That massively simplifies things!
> 
> > If you like I can reach out to OASIS to confirm.
> 
> Yes, that'd be very helpful, thank you.


Well OASIS got back to us with the following:

	they have a tool that requires you to create an account then you file
	a CLA. If using email maintainer needs to check CLA in place.
	If using github pull requests, it checks automatically.
	Additionally each employer also has to file a different employer CLA.
	This last one for now has to just be emailed but at some point
	they will develop a tool to do that. They said "shortly" but no
	promises.
	Until they do, maintainer has to remember to check employer CLA
	is on file when merging.

If you want to bother with all this let me know I will get you set up.

	Or another option is to just create a repo elsewhere.  If we
	really want to we can make people accept CLA, then if at some point
	OASIS has better infra, transition to that.  I'd then use BSD-3-Clause
	License if that's ok, in case we do want to move to OASIS later.


	How do you intend to work, pull requests or email?






> 
> -- 
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd

