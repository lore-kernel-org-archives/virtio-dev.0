Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EE15B969
	for <virtio-dev@lists.linux.dev>; Fri,  7 Jun 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753316; cv=none; b=ltYISVm5mG5kRkezn37EZF4yCm4wvYV3xp/U7aXxgV8eP7wFQ1uarJEckQgjrYY9D7+t9kylPZ34FXmW8JgVUzmgF81e7ZyXgAXGp7f47rkx27/AnBerCwjpTiRW7QSJC8jIyHcfCJkia5U/YH5eF5bHFeWeG/pWktz0AJk0pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753316; c=relaxed/simple;
	bh=MJz8M2ob481Dib8t/BMGrIwhPG4PX6TFwfsDhWGsU5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i+zVRmHcB79okMhcTECQVL9GfEF2c1YmHRAKfefC8DuKXlvpyH2nmJjsPo8h/ayHQjZbAe4et2vDDJ2iMRopr+sHSJgUB6LJvsytlMqV/YKDwwB0+LpNYq1lQLRLhUkiArgnnovbUYxxiFjKKWndiIUlXvvIPy1O+XQ2dKC11BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUdUn3kE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUdUn3kE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717753314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pL5L3Pv/nSIjK9K4Rb+X0AGzikPBKIJoA4e+Z7suRIQ=;
	b=IUdUn3kEzLOh/gRyV3BCglfHjg25a/XBTX1zbBjW+frGW8QZb6PQJAvk2cESTjMptykXew
	rBaGENhKYHBUphvA9UWdgkdIbtS/8qKXNPM1+ugFJwombeEpWJvvbKmYOBPQtnEeuITAYI
	e/X7UXx2fdqwR7jbXTgJQ2bw0c0unpA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-CReEHMvjNCWIAqMghbv2PQ-1; Fri, 07 Jun 2024 05:41:52 -0400
X-MC-Unique: CReEHMvjNCWIAqMghbv2PQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a68e0faf1f6so115628366b.3
        for <virtio-dev@lists.linux.dev>; Fri, 07 Jun 2024 02:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717753311; x=1718358111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL5L3Pv/nSIjK9K4Rb+X0AGzikPBKIJoA4e+Z7suRIQ=;
        b=N57HmJqbNgcEbyM2p2s0HaQxxl/6K886jc2JE0pF5UiTrA2eHGErUlqt4QOcv6KEMs
         8TMC/Sh+iGiwm1fhgdTyOr8f2/4kvhLOm9h4yqRUAe4pxVkzoOCUmNMdFnGFd4opDM2Q
         nwJn1PFgJm85YhLhjcHHBxNXZizfJECyNcbkBgO3NBt+jf85Pd8fZBaVJsT2ZjZzLSjC
         bdtEF/WF3G1MWwWtd2MDNKfVabwQgpETvTi4x8HWpi1q/1dcVxEdlta9p0qvFRPw/ilI
         XtnHxhrZ1hZCPcWXU7K2qm1bCobX9Q30uAEW4fUT3ztb/ZnajcCVg56poHfdXDGQZ6Nv
         5v0Q==
X-Gm-Message-State: AOJu0YwAd2pzqTI4t3e4h65nbgF3pv/j/U393bHky2TQp/vmn2BgBSlB
	3C21YypkPobE38jfC2fowbarmTdXtYNKo1lDY6MuJZCrd1NffkXZ9jXHtljEW9M2fnI1IHuRGLJ
	/IEuJPH3GR/dA1XpTkTi5OawL4lUM8ZwNh1PHhifyeRzCUELXrKMOst362jA=
X-Received: by 2002:a17:906:819:b0:a6e:f53c:8da1 with SMTP id a640c23a62f3a-a6ef53c9204mr13224266b.32.1717753311127;
        Fri, 07 Jun 2024 02:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4zQipaQH9CTHM9i7wTyKnldgRuuw1xPmH/WKSqTFjvFUwm/NBTJYVWcXx5pUHA1wv2kpKcQ==
X-Received: by 2002:a17:906:819:b0:a6e:f53c:8da1 with SMTP id a640c23a62f3a-a6ef53c9204mr13222066b.32.1717753310665;
        Fri, 07 Jun 2024 02:41:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072ae3esm219776966b.225.2024.06.07.02.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:41:50 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:41:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: virtio-dev@lists.linux.dev, Matti.Moell@opensynergy.com,
	cohuck@redhat.com, acourbot@chromium.org,
	daniel.almeida@collabora.com, Alexander.Gordeev@opensynergy.com,
	changyeon@google.com, alex.bennee@linaro.org,
	gurchetansingh@google.com, ribalda@google.com,
	nicolas.dufresne@collabora.com, eballetb@redhat.com,
	linux-media@vger.kernel.org, virtio-comment@lists.oasis-open.org
Subject: Re: [PATCH v2 0/1] virtio-media: Add device specification
Message-ID: <20240607053839-mutt-send-email-mst@kernel.org>
References: <20240607080045.1337046-1-aesteve@redhat.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240607080045.1337046-1-aesteve@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2024 at 10:00:44AM +0200, Albert Esteve wrote:
> Hi,
> 
> This a formal attempt of including virtio-media
> device specification.

This was sent to a wrong mailing list.
Please repost to the correct list.

Albert, when you subscribed to virtio-dev you should
have received a message that read, in part:

When to use this list:
- questions and change proposals for Virtio drivers and devices
  implementing the specification.

When not to use this list:
- questions and change proposals for the Virtio specification,
  including the specification of basic functionality, transports and
  devices (please use the virtio-comment mailing list
  [mailto:virtio-comment@lists.linux.dev] for this).

To do:
- send email preferably in text format (best for archiving)

Not to do:
- copy both virtio-dev and virtio-comment mailing lists (instead, pick
  one)
- send full copies of the virtio spec (in any format)



So what made you send a specification change proposal to
virtio-dev, and also copy the defunct, non-functional
list at virtio-dev@lists.oasis-open.org ?


Was the message unclear? If yes I'd like to improve it.


-- 
MST

