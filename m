Return-Path: <virtio-dev-return-12083-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2052FC76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 10:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C10AD2AC5A
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 10:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53EAC98660D
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 10:05:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF6A798636D; Mon, 10 Apr 2023 10:05:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 692B8986321
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 10:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 9kD0_81wOvKdOVfWTa1MSg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681121048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtEbMCwMnkI2VdNhYUQPmDl2IgpBxhJ69FS4TtXZ9j8=;
        b=6RCnacZK7sGUCVMR9fZ+biQrWzg/IvrrzUughLhqSzZqjknKvGPB4rzQpt/Q0PBqE+
         g9TD+iqSrenGxDlpUGg7gV/KM6j+OmKvI7Ur+S1FHY6DjqGfbfWSQc8qoB8f9mcTM5G4
         +wKNcXpH47oHs9fBZ77X3BSuMlV2jMQm6g6re0ec+fSGf9cKVbW+ITqsTrC6rEHJRehK
         dgDrjlX+CjLS8cnc/ma5qYw1QCyrDXo1y9QhuUx0Vc/tqyVG8qQ5g9bpAKGswHP53Yp+
         mazf0el3yDAEKByg/8lfcILnIy0CDKA5480lhqK6hlc42uUmpWxVlGp48GB1k/nA+Seu
         iXtA==
X-Gm-Message-State: AAQBX9cZ8twHHr3lXp0axxdzRq/qtkvF5cTs4kK2/LhXX2G7eI0PjQgK
	x55NcRTKHry+bKvBbnVM4S+9OAoTjfHNitHQl+RlCgCySwPaMg6Mb5hBiVXm6nc/hO0Bo8MVrdg
	4OfjaHNXzwPdpvQQ1mRS80WhBf/2v
X-Received: by 2002:a1c:f219:0:b0:3ea:d620:57a7 with SMTP id s25-20020a1cf219000000b003ead62057a7mr7219781wmc.8.1681121048101;
        Mon, 10 Apr 2023 03:04:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZPXmVZcVyMjFIOdnBtpKQoncHXttB5viMKOgSDbZnlDMH3eTAQE0TsdoH+r0NwhQ+iWgTALw==
X-Received: by 2002:a1c:f219:0:b0:3ea:d620:57a7 with SMTP id s25-20020a1cf219000000b003ead62057a7mr7219769wmc.8.1681121047811;
        Mon, 10 Apr 2023 03:04:07 -0700 (PDT)
Date: Mon, 10 Apr 2023 06:04:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>
Message-ID: <20230410055947-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <20230410021619-mutt-send-email-mst@kernel.org>
 <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Mon, Apr 10, 2023 at 03:16:46PM +0800, Jason Wang wrote:
> On Mon, Apr 10, 2023 at 2:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Apr 10, 2023 at 09:36:17AM +0800, Jason Wang wrote:
> > > On Fri, Mar 31, 2023 at 7:00 AM Parav Pandit <parav@nvidia.com> wrote:
> > > >
> > > > PCI device configuration space for capabilities is limited to only 192
> > > > bytes shared by many PCI capabilities of generic PCI device and virtio
> > > > specific.
> > > >
> > > > Hence, introduce virtio extended capability that uses PCI Express
> > > > extended capability.
> > > > Subsequent patch uses this virtio extended capability.
> > > >
> > > > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > >
> > > Can you explain the differences compared to what I've used to propose?
> > >
> > > https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08078.html
> > >
> > > This can save time for everybody.
> > >
> > > Thanks
> >
> > BTW another advantage of extended capabilities is - these are actually
> > cheaper to access from a VM than classic config space.
> 
> Config space/BAR is allowed by both of the proposals or anything I missed?
> 
> >
> >
> > Several points
> > - I don't like it that yours is 32 bit. We do not need 2 variants just
> >   make it all 64 bit
> 
> That's fine.
> 
> > - We need to document that if driver does not scan extended capbilities it will not find them.
> 
> This is implicit since I remember we don't have such documentation for
> pci capability, anything makes pcie special?

yes - the fact that there are tons of existing drivers expecting
everything in standard space.


> >   And existing drivers do not scan them. So what is safe
> >   to put there? vendor specific? extra access types?
> 
> For PASID at least, since it's a PCI-E feature, vendor specific should
> be fine. Not sure about legacy MMIO then.
> 
> >   Can we make scanning these mandatory in future drivers? future devices?
> >   I guess we can add a feature bit to flag that.
> 
> For PASID, it doesn't need this, otherwise we may duplicate transport
> specific features.

i don't get it. what does PASID have to do with it?
A new feature will allow clean split at least:
we make any new features and new devices that expect
express capability depend on this new feature bit.

> >   Is accessing these possible from bios?
> 
> Not at least for the two use cases now PASID or legacy MMIO.

can't parse english here. what does this mean?


> >
> > So I like this one better as a basis - care reviewing it and adding
> > stuff?
> 
> There are very few differences and I will have a look.
> 
> Thanks
> 
> >
> > --
> > MST
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

