Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162A54662
	for <virtio-dev@lists.linux.dev>; Tue, 21 May 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277302; cv=none; b=ASHN3ToiDBhUFzoIoaoc1SHWXS+f6pY3SqDv3LO386bDe1OuqpP7oQD+mzUIAB4dlDTl2uvZsuOw5iyjF4PViDU13D9kUepAfpgMUNwiKRK95nBFA+4LiOxqbMKy5PAX6czKDLk3eH67E3ku7SQPkZHKATffKQWTVSwU1vgbOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277302; c=relaxed/simple;
	bh=0lncSlGrY02MeYH+JM38m7KGKCnvttSuASJBVwOnWAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VDdIRKgoN2fWpVK/2p6RK4gc7/m1bNPQHbFpfnT/EWmIXgtUMz94widsb8HQHzw6pV5uEVeXt++ltcVH7Ya5kue5dt5OwtJHlxHmhv1hUWWrotLOIWVdouoOg3EdqfVRvV0TW4e3ggDTyCAtM0qeExPKh96ulJ+eXxYjzFYofbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDm0fbkY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDm0fbkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716277300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPmaWSZvkez+HgT998ML9qXTfsyE2zaekX+lcOpu0pM=;
	b=MDm0fbkYax0WAgHefwa6+lyiXISA3uAQWtpYZ86hGPlwZKDygrOSxM4HJsiFKNTd/ezD4b
	lyDd1Hf+E/yZyJ1IAMZLKJpU50uBB1W1t2cw6Q0BN2bIKqsq82qnsWrYK6aQ7ema/3wLD+
	279OeO5AJVAVzrepXwyS2GYj4KNVYQ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-jIe-qJFENRmQ5FKbmleLsw-1; Tue, 21 May 2024 03:41:38 -0400
X-MC-Unique: jIe-qJFENRmQ5FKbmleLsw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41fe6df6ef3so56820425e9.2
        for <virtio-dev@lists.linux.dev>; Tue, 21 May 2024 00:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716277298; x=1716882098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPmaWSZvkez+HgT998ML9qXTfsyE2zaekX+lcOpu0pM=;
        b=K9nX8oFi9A2kWFRZW4NlP/ZtFC9R/Q4J5uu96tbaGR49N0x/lRuVQ3WeHO9Zwf9Q/O
         K4yVTQruVvT90YGzEAoUre/rY1YSeQm2GCh3ynr1lbypgwYaYJXQWXiXPH4KbGuxfHwK
         tWNk0hLfYdkEJbAvDjAirnQxBuzhKsjNqROzvSs/zzG1MsF0K9iWeuJeWXyFhNYBA05I
         OoWBmOoGGvYa/I982Dzs+SWNTwvdVjcOB18JZvcqcKN6HMIHNMSdPExzVskUHlV9GacQ
         wrnh0GPLN33up6xkMkI/YDul3qT1J87l7+TKuwM5I/yUvHlgafsL/pe1QbLJz2a2wZ0O
         HU7w==
X-Gm-Message-State: AOJu0YzgU6yA8UJh375ljAHWw5AXLU3t5VDewifans16pupUJ6PlBO12
	tKlcD3M3IuuRFpPu+a/bEj5QTODJsMlbjBeYtB/kSU9xyDh2ipT378BMY0RqMNTq840HUEzae7L
	rnMhs9wBlvGR2eG5T64eDZZ/Z1QKjaQiU32l2kZrzSa0/mmiaM4iDmqXpI+g=
X-Received: by 2002:a05:600c:a41:b0:41d:7d76:ffd4 with SMTP id 5b1f17b1804b1-41feaa2f3e4mr231832725e9.8.1716277297603;
        Tue, 21 May 2024 00:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpBqWjC6YAPBK6HZW5QJ5CUMWBzEBX8PU1z3PKQIIWYzAeIgUNOeoopEZY8QZ71GuDXUH1cw==
X-Received: by 2002:a05:600c:a41:b0:41d:7d76:ffd4 with SMTP id 5b1f17b1804b1-41feaa2f3e4mr231832475e9.8.1716277296998;
        Tue, 21 May 2024 00:41:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5a20:b565:3672:6f2b:3d2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm488863035e9.29.2024.05.21.00.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 00:41:36 -0700 (PDT)
Date: Tue, 21 May 2024 03:41:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: virtio-dev@lists.linux.dev, maxime.coquelin@redhat.com,
	Eelco Chaudron <echaudro@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3] virtio-net: define UDP tunnel offload feature
Message-ID: <20240521034028-mutt-send-email-mst@kernel.org>
References: <f0bf2db203f8061a3ecb50b7a48cf26d8f3c7f68.1716193086.git.pabeni@redhat.com>
 <20240520225254-mutt-send-email-mst@kernel.org>
 <2dd731c45ee016fcca416d18d21882947bbf9f9d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2dd731c45ee016fcca416d18d21882947bbf9f9d.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 21, 2024 at 09:25:51AM +0200, Paolo Abeni wrote:
> Hi,
> On Mon, 2024-05-20 at 22:55 -0400, Michael S. Tsirkin wrote:
> > when you subscribed to virtio-dev you should have received this:
> > 
> > When to use this list:
> > - questions and change proposals for Virtio drivers and devices
> >   implementing the specification.
> > 
> > When not to use this list:
> > - questions and change proposals for the Virtio specification,
> >   including the specification of basic functionality, transports and
> >   devices (please use the virtio-comment mailing list
> >   [mailto:virtio-comment@lists.linux.dev] for this).
> > 
> > 
> > Did you receive this? 
> 
> Yes, I received it.
> 
> > If yes was this somehow unclear?  If no why are you sending a Virtio 
> > specification change proposal to virtio-dev?
> 
> Given your reply I guess my interpretation was wrong.

What was your interpretation?

> Should I reply to
> Jason and Stefano feedback here, or move the discussion entirely on
> virtio-comment? 
> 
> Thanks,
> 
> Paolo

Repost to virtio-comment I think, restart the discussion.

-- 
MST

