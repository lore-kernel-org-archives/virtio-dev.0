Return-Path: <virtio-dev-return-12118-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2720C77B6F
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:44:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4AA9A2A880
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:44:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D1FA986549
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 10:44:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 33953986366; Tue, 11 Apr 2023 10:44:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2447F986371
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 10:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: rO8VU5CdM2KcNUMI5tYxUw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k07uTL22V0AZ5IbEZj1qepDG0kqGd6h46AyrcvO7PWg=;
        b=pacnm9mQFnBVtSALR+JeVqxTt0qGL03rcFMANbfseBo/t/AU+tvVavJmpS/uKIcbVr
         9kcXiGzLoTtlTK3ELPsdBhRn924usUZeEzFoQihn7lvDqkG+lR9HzEkisPDwdVqcmCVK
         Lxj9yuSIYYC0cm/vhOI9p9rKCCYmCegUNFssaWh2qGSwcp5y4phQNhgIimtWqq8Sc3Yf
         2oj59TiWvDrLN3BlPXtzfjyaBnLP7Z7DY7FNJzld2NPvbiwLiE80PHpQ+byO6NrIiKMz
         mIDt3kxVC2rJWJ8s8/rxPXcFe/rYDfpdECAq+oj1W9n07k4C+N95g1jFpKorBrHHUOss
         OceA==
X-Gm-Message-State: AAQBX9cEHrwIOY/epZg8g70JHtuVvHKu6p+hXWsz5nbnj6JxgXUe9+Ar
	WosOPZ9ridYCdPA0X/QWsRMizxfgSM5Tah+hlzQxZR+1I2MdexLmx1zRSTp8f+kleNrH9LtX58+
	W3EaEFC37eEr4qw6Xn/0HkCBZng5s
X-Received: by 2002:a7b:ce88:0:b0:3e1:f8af:8772 with SMTP id q8-20020a7bce88000000b003e1f8af8772mr9776164wmj.9.1681209839063;
        Tue, 11 Apr 2023 03:43:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350YFO+CKJ+uRVi5AGPgvz09qJuDUI2nE4E+ZYE9JaDcRsAuJrj9LtfIGqzPolg+s1XvcQYvIOg==
X-Received: by 2002:a7b:ce88:0:b0:3e1:f8af:8772 with SMTP id q8-20020a7bce88000000b003e1f8af8772mr9776154wmj.9.1681209838691;
        Tue, 11 Apr 2023 03:43:58 -0700 (PDT)
Date: Tue, 11 Apr 2023 06:43:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>
Message-ID: <20230411064333-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <20230410021619-mutt-send-email-mst@kernel.org>
 <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
 <20230410055947-mutt-send-email-mst@kernel.org>
 <CACGkMEsKLeJ1q3Vh8h2JYM=-RcrGd+31yR1Zsw0U=SRd1JZugg@mail.gmail.com>
 <20230411025646-mutt-send-email-mst@kernel.org>
 <CACGkMEui1ouE8DcXKkWUavToUT+vEP-c640vtw3BJBOSz5YTkw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEui1ouE8DcXKkWUavToUT+vEP-c640vtw3BJBOSz5YTkw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Tue, Apr 11, 2023 at 05:07:11PM +0800, Jason Wang wrote:
> On Tue, Apr 11, 2023 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 11, 2023 at 10:19:39AM +0800, Jason Wang wrote:
> > > On Mon, Apr 10, 2023 at 6:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Apr 10, 2023 at 03:16:46PM +0800, Jason Wang wrote:
> > > > > On Mon, Apr 10, 2023 at 2:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 10, 2023 at 09:36:17AM +0800, Jason Wang wrote:
> > > > > > > On Fri, Mar 31, 2023 at 7:00 AM Parav Pandit <parav@nvidia.com> wrote:
> > > > > > > >
> > > > > > > > PCI device configuration space for capabilities is limited to only 192
> > > > > > > > bytes shared by many PCI capabilities of generic PCI device and virtio
> > > > > > > > specific.
> > > > > > > >
> > > > > > > > Hence, introduce virtio extended capability that uses PCI Express
> > > > > > > > extended capability.
> > > > > > > > Subsequent patch uses this virtio extended capability.
> > > > > > > >
> > > > > > > > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > >
> > > > > > > Can you explain the differences compared to what I've used to propose?
> > > > > > >
> > > > > > > https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08078.html
> > > > > > >
> > > > > > > This can save time for everybody.
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > BTW another advantage of extended capabilities is - these are actually
> > > > > > cheaper to access from a VM than classic config space.
> > > > >
> > > > > Config space/BAR is allowed by both of the proposals or anything I missed?
> > > > >
> > > > > >
> > > > > >
> > > > > > Several points
> > > > > > - I don't like it that yours is 32 bit. We do not need 2 variants just
> > > > > >   make it all 64 bit
> > > > >
> > > > > That's fine.
> > > > >
> > > > > > - We need to document that if driver does not scan extended capbilities it will not find them.
> > > > >
> > > > > This is implicit since I remember we don't have such documentation for
> > > > > pci capability, anything makes pcie special?
> > > >
> > > > yes - the fact that there are tons of existing drivers expecting
> > > > everything in standard space.
> > > >
> > > >
> > > > > >   And existing drivers do not scan them. So what is safe
> > > > > >   to put there? vendor specific? extra access types?
> > > > >
> > > > > For PASID at least, since it's a PCI-E feature, vendor specific should
> > > > > be fine. Not sure about legacy MMIO then.
> > > > >
> > > > > >   Can we make scanning these mandatory in future drivers? future devices?
> > > > > >   I guess we can add a feature bit to flag that.
> > > > >
> > > > > For PASID, it doesn't need this, otherwise we may duplicate transport
> > > > > specific features.
> > > >
> > > > i don't get it. what does PASID have to do with it?
> > >
> > > My proposal is to allow PASID capability to be placed on top.
> >
> > Assuming you mean a patch applied on top of this one.
> >
> > > So what
> > > I meant is:
> > >
> > > if the driver needs to use PASID, it needs to scan extend capability
> > >
> > > So it is only used for future drivers. I think this applies to legacy
> > > MMIO as well.
> >
> > sure
> >
> > > > A new feature will allow clean split at least:
> > > > we make any new features and new devices that expect
> > > > express capability depend on this new feature bit.
> > > >
> > > > > >   Is accessing these possible from bios?
> > > > >
> > > > > Not at least for the two use cases now PASID or legacy MMIO.
> > > >
> > > > can't parse english here. what does this mean?
> > >
> > > I meant, it depends on the capability semantics. Both PASID and legacy
> > > MMIO don't need to be accessed by BIOS. We can't change legacy BIOS to
> > > use legacy MMIO bars.
> > >
> > > Thanks
> >
> > makes sense.
> >
> >
> > now, imagine someone building a new device. if existing drivers are not
> > a concern, it is possible to move capabilities all to extended space. is
> > that possible while keeping the bios working?
> 
> This is possible but I'm not sure it's worthwhile. What happens if the
> device puts all capabilities in the extended space but the bios can't
> scan there?

that's my question. can seabios access extended caps?

> We can place them at both but it then doesn't address the
> out of space issue. Things will be easier if we allow new
> features/capabilities to be placed on the extended space.
> 
> Thanks
> 
> >
> > > >
> > > >
> > > > > >
> > > > > > So I like this one better as a basis - care reviewing it and adding
> > > > > > stuff?
> > > > >
> > > > > There are very few differences and I will have a look.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

