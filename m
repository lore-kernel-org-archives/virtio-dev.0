Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA651CF281
	for <virtio-dev@lists.linux.dev>; Thu, 10 Oct 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569768; cv=none; b=lKG32JQgR3DTqipsMHdlL/ciryOC6xOg4yyzU2Jpn7oqOpnLCyAx76GX3kDQBmwAqy+bOfQHE1KWplQa50kr1rW/DIENkbjrr4qDE2r+psNXWzIRHHh992CutLmTiYl2DfiomiPK7rON5UIw1xTa17lik7Fcu5FffIhv0HM4GHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569768; c=relaxed/simple;
	bh=H7OVQVkmlp50arWBH4CMVe4fVD2e0/VM1ZzNEAmm3Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ap+slSd4GUSdDsbfyBj/bCaUb6kW2+pGZsPh1IiAeDaEsf/i9fEzXovDAtg4MWBF4V+dzGdGmxZjlDVLLuPrQdU1d3Ao0vhn7Ip6CfMXwWAz4UGoc/w1vJGtapy1BAsfTQO8cCH+PKs3z2GzHZKbvrl+2czlvq/MBccpkgRDX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWNj4P5b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWNj4P5b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728569765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hnXbQWY2la7bHGRN3tmpJWIXjnTy7RCcsDoClnyV/ZM=;
	b=PWNj4P5bbyGzhl442mKQgD3gcBw2e8rtgsfuB2es4frOin0CSbl7MTRtQ7TwAmTyJVhTen
	Nc/JX8j7JMZOr+YV6gyaBPBgVFn2IFqZGClwUk8d5V/ot57hodRazBtKKjG/lDAKirMnNY
	7fqMQBfDCCzabvtXgiwkYkCgMyvLXCM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-zuYLfBa3MHST0_v4p2qj7g-1; Thu, 10 Oct 2024 10:16:03 -0400
X-MC-Unique: zuYLfBa3MHST0_v4p2qj7g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43113dab986so8538015e9.2
        for <virtio-dev@lists.linux.dev>; Thu, 10 Oct 2024 07:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569762; x=1729174562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnXbQWY2la7bHGRN3tmpJWIXjnTy7RCcsDoClnyV/ZM=;
        b=peuwrxPCLlhUlO1aNBpqXuQhXvyrwLsx+Bmyi7TvoRfIF24zZUiPOcAYSnfuGkIhHy
         dq2BGkinee1owetGooKLPYvZkdoe85XGMcQs4wmMWmeHa79D0Yi+Z7xOQs0QNgV+J197
         FpBxSjckBzspFekqUu1NvypPzUdLEcE1jx5EBwzjoI85eO7hudC0QmwSWeBxv9JbGqvK
         ppas0IWDitwi4OKG1NfWXoFxAmbiqYIkjeV4QqbwUmC4OOt1SsVtxP0MusbfseXwEqVF
         CBRMa0u5Y22GSLKZtKw0xM+rSmG8LTx1PDutVIhWKri1ayQFuNaGt/EiQePTTrQIoAeU
         dTYg==
X-Forwarded-Encrypted: i=1; AJvYcCUrp7v7K7J0PR9RKAR5lWcE7bKwit2cqHFzMsTW5Wk+PiqfAe8lSJ4EfMBriki+Mif+UX4QfpcRMULM@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6SVghsY3XctzQK5I1Z7qvViOb7UBxeYc7gQUYirNP5C4hasQI
	Lmr/39UljmZBUePfPJrqWV4JPCEOHjk4KDnPJyh2HnT21C0TH3MAw/llaYhkkx1q+KjN6Qi9WZ/
	wBhOu/ynL1Cksa1K6M5S25A1YvdCAo5ZVuTqqdb2qQHds+kVa8vIY5G4y4Mw=
X-Received: by 2002:a05:600c:458a:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-430ccf432aamr77059345e9.17.1728569762181;
        Thu, 10 Oct 2024 07:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbc7ZgEO6oTw7aFDJ8bb8UXfHnaMLSJbOPjwcffSHpNJiFT4jfQ32Fn/4ykgSL8BZMmS6Qfw==
X-Received: by 2002:a05:600c:458a:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-430ccf432aamr77058895e9.17.1728569761762;
        Thu, 10 Oct 2024 07:16:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:fb13:fd72:22f:64e2:b824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f69dsm1662112f8f.81.2024.10.10.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:16:00 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:15:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	dverkamp@chromium.org, virtualization@lists.linux-foundation.org,
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com,
	parav@nvidia.com, nitzanc@nvidia.com, benwalker@nvidia.com
Subject: Re: [PATCH v3 1/1] virtio-blk: Add description for blk_size field
Message-ID: <20241010101235-mutt-send-email-mst@kernel.org>
References: <20241009160512.8390-1-mgurtovoy@nvidia.com>
 <ZwerV4qPST9bbJ1O@fedora>
 <e893a183-0eb4-4888-a8b3-25c1ca12464f@nvidia.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e893a183-0eb4-4888-a8b3-25c1ca12464f@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2024 at 05:04:55PM +0300, Max Gurtovoy wrote:
> 
> On 10/10/2024 13:24, Matias Ezequiel Vara Larsen wrote:
> > Hello,
> > 
> > I wrote some minor comments below.
> > 
> > On Wed, Oct 09, 2024 at 07:05:12PM +0300, Max Gurtovoy wrote:
> > > This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> > > offered by the device.
> > > 
> > > The blk_size field actually represents the logical block size of the
> > > device. It is always a power of two and typically ranges from 512 bytes
> > > to larger values such as 4 KB.
> > > 
> > > Add description for this field to provide clarity on its constraints.
> > > 
> > > Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 34 insertions(+)
> > > 
> > > diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
> > > index 2712ada..caa5d13 100644
> > > --- a/device-types/blk/description.tex
> > > +++ b/device-types/blk/description.tex
> > > @@ -135,6 +135,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
> > >   present. The availability of the others all depend on various feature
> > >   bits as indicated above.
> > > +The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is offered by the device.
> > > +This field reports the block size of the device, expressed in bytes.
> > > +
> > >   The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
> > >   the number of queues.
> > > @@ -282,6 +285,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
> > >   \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
> > > +Drivers SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by the
> > > +device. When negotiated, drivers SHOULD interpret the \field{blk_size} as the
> > > +logical block size.
> > > +
> > > +If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then drivers
> > > +MAY assume that the logical block size is 512 bytes.
> > > +
> > >   Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
> > >   sending VIRTIO_BLK_T_FLUSH commands.
> > > @@ -319,6 +329,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
> > >   \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
> > > +Devices SHOULD always offer VIRTIO_BLK_F_BLK_SIZE feature. When this feature is
> > > +offered, devices MUST initialize \field{blk_size} to a power of two greater
> > > +than or equal to 512.
> > > +
> > >   Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> > >   if they offer VIRTIO_BLK_F_CONFIG_WCE.
> > > @@ -879,6 +893,14 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
> > >   The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
> > >   and VIRTIO_BLK_T_OUT requests.
> > > +The length of \field{data} SHOULD be a multiple of \field{blk_size} for VIRTIO_BLK_T_IN
> > > +and VIRTIO_BLK_T_OUT requests, when the VIRTIO_BLK_F_BLK_SIZE feature has been
> > > +offered by the device.
> > > +
> > I would rewrite it as:
> > 
> > `When the VIRTIO_BLK_F_BLK_SIZE feature has been offered by the device,
> > the length of \field{data} SHOULD be a multiple of \field{blk_size} for
> > VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests`
> > 
> > Just because people tend to read from more important to less important
> > within a sentence but I do not have an strong opinion about it.
> > Apologies if I may sound bit picky ;).
> 
> I don't have a strong opinion on it as well.
> 
> I'm open to making changes, but I'd appreciate getting input from MST/Stefan
> first.
> 
> This way, we can ensure we're aligning with their perspective and avoid
> potential back-and-forth revisions.

Please put the condition first, then the result, this is standard
english.

You can also combine multiple things then.

Also, it should be "is offered".

> > 
> > > +The value of \field{sector} (multiplied by 512) SHOULD be a multiple of
> > > +\field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests, when the
> > > +VIRTIO_BLK_F_BLK_SIZE feature has offered by the device.
> > > +
> > For the same reason, I would rewrite it as:
> > 
> > `When the VIRTIO_BLK_F_BLK_SIZE feature has offered by the device, the

has offered is agrammatical.

> > value of \field{sector} (multiplied by 512) SHOULD be a multiple of
> > \field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests`.
> > 
> > I think I would follow this pattern in the text below too.
> > 
> > >   The length of \field{data} MUST be a multiple of the size of struct
> > >   virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
> > >   VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
> > > @@ -966,6 +988,18 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
> > >   for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
> > >   write any data.
> > > +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
> > > +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the requested
> > > +\field{sector} (multiplied by 512) is not an integer multiple of the device's
> > > +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offered by
> > > +the device.
> > > +
> > > +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
> > > +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the length of the
> > > +requested \field{data} is not an integer multiple of the device's
> > > +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offered by
> > > +the device.
> > > +
> > >   The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
> > >   discard, secure erase and write zeroes commands if any unknown flag is set.
> > >   Furthermore, the device MUST set the \field{status} byte to
> > > -- 
> > > 2.18.1
> > > 
> > > 

