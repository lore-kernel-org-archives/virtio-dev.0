Return-Path: <virtio-dev-return-12079-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC0CC77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 06:24:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4DCB12B01A
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 06:24:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2BCC5986371
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 06:24:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1133E984216; Mon, 10 Apr 2023 06:24:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2B8E9862A5
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 06:24:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: eJiu9iHNOBKpFhkZn2pQ-w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681107881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SyrjmAdl5eX1xK1e5c4mE02FdLQujtoDgxmvm2oHCU=;
        b=fienOHZsNqU0LLPowZ2QVdazYdUkW7Ramxxju02UfUo/Vo+G+2hTifWaI3bTDNEZhu
         MZpguyJk8rG/Z70v4R2Hm2RCOQ8x+N1FCcrftuzUcRrnnBUCoyfNnCN6tI8EsBVxu28p
         CbQp8bn1PW1cuDy3OllzPwWFYtoJJxU2dgCEuoHhREvHjvih4OaGx+N++CeogxjQbjrn
         hxMWTRQx2BGmO3Hd3SOPqEFZBzBJ/ErO0X0ySIMB10C0BtuVwVYnB9Jr8SXRRKgI0/Hp
         +pfnRHiwVPI6E9hEoRCf15vaKHtYmvweGR94zvzRaT8dDKfvXTA0Cgh/RWi/90Hx/h2x
         hpoA==
X-Gm-Message-State: AAQBX9ejKjl/CscwJkp51L3mpaiViA+FA6XSiEbSARZLZHRaEPJCKNtR
	nvPMGe5UGiAjUB28U0xJ4WKNjBJ4rl6NdJAus4YRgFDypH4tmr2HcjNw1L5c3HjoHhDW8p20zu3
	pLMKgc4Yhzcv8uPTkAGEEzxF1YC5r
X-Received: by 2002:a7b:c843:0:b0:3f0:7b28:e393 with SMTP id c3-20020a7bc843000000b003f07b28e393mr5699027wml.9.1681107881494;
        Sun, 09 Apr 2023 23:24:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350YE8+f9NFy9EMHc+sI5u0xsirWpDIfiicfnidL5VFKdmln2+ttkaSXBOATSO9ukPwkw+FGm1w==
X-Received: by 2002:a7b:c843:0:b0:3f0:7b28:e393 with SMTP id c3-20020a7bc843000000b003f07b28e393mr5699018wml.9.1681107881213;
        Sun, 09 Apr 2023 23:24:41 -0700 (PDT)
Date: Mon, 10 Apr 2023 02:24:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>
Message-ID: <20230410021619-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Mon, Apr 10, 2023 at 09:36:17AM +0800, Jason Wang wrote:
> On Fri, Mar 31, 2023 at 7:00 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> > PCI device configuration space for capabilities is limited to only 192
> > bytes shared by many PCI capabilities of generic PCI device and virtio
> > specific.
> >
> > Hence, introduce virtio extended capability that uses PCI Express
> > extended capability.
> > Subsequent patch uses this virtio extended capability.
> >
> > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> Can you explain the differences compared to what I've used to propose?
> 
> https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08078.html
> 
> This can save time for everybody.
> 
> Thanks

BTW another advantage of extended capabilities is - these are actually
cheaper to access from a VM than classic config space.


Several points
- I don't like it that yours is 32 bit. We do not need 2 variants just
  make it all 64 bit
- We need to document that if driver does not scan extended capbilities it will not find them.
  And existing drivers do not scan them. So what is safe
  to put there? vendor specific? extra access types?
  Can we make scanning these mandatory in future drivers? future devices?
  I guess we can add a feature bit to flag that.
  Is accessing these possible from bios?

So I like this one better as a basis - care reviewing it and adding
stuff?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

