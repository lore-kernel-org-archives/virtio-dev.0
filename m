Return-Path: <virtio-dev-return-12646-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A162C77B7F
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 11:35:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B8B3B60047
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 11:35:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D2899865EC
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 11:35:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 888959865CE; Thu, 11 May 2023 11:35:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75AC69865DB
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 May 2023 11:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jlgq4jMRPNaTy_-e6NtnVg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683804929; x=1686396929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZSBfXuFCGG+LmOZLKmSUzz6FTumra09/CTJfJIUl5Q=;
        b=MDIoI28FtfwD9SSAESTr514EwaxhR1dhj2uhKz9AFugsqifbPXPF1lo/ON58hpMAXz
         YRJc4HAwJkkRcdGpox9eGogonZ0dkKssI+kQcFEr9vs0sT02/gXKfGQs+eFwiMf1SBZD
         fN7XKoYsozRMGUoJ9m83ThiX0+a5rx/691Ps3COfr0jAthiqICIUpT5W03dq2C9EZ9xo
         AVbCOpEo7DyLyqjFSKdPvFpBhJWQkgCOO9gdt5DnChviOGbKytwPnvrx4rXfb8TUIbF1
         NSoSx7kfUF1WxkXT6rwbtfrCAgEmhT6RIhbqba5+WkRLfkHQjnSpWDMcQ1oz6zzhOSSd
         OTSA==
X-Gm-Message-State: AC+VfDxTlHkCxgFtAnDc1GZYG8AsXF/3BR51x5UEVeOypyg3CGnY/5dd
	3DhueauSzXiV5XmCGcfDd0S7fT11Y9lcA0AJB1J9H+6AaxSO8VH0gtwuMa9MYgsqwN7Kol+1Yjt
	6JJrU1V7ualQQN4UzNPjovusICmzV
X-Received: by 2002:adf:f407:0:b0:307:c1cb:425b with SMTP id g7-20020adff407000000b00307c1cb425bmr2744595wro.70.1683804929770;
        Thu, 11 May 2023 04:35:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zajKACV+/fdUTNWuZOa65upK7+xg5UW3Mw/jGg8pHje/ZAsY861Ej9VN2umwJdiO+oMyTJA==
X-Received: by 2002:adf:f407:0:b0:307:c1cb:425b with SMTP id g7-20020adff407000000b00307c1cb425bmr2744558wro.70.1683804929483;
        Thu, 11 May 2023 04:35:29 -0700 (PDT)
Date: Thu, 11 May 2023 07:35:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230511073218-mutt-send-email-mst@kernel.org>
References: <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
 <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
 <PH0PR12MB5481AC52CCAE9636E17C7565DC769@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu1oU0wzygicS0bApoWuRaWkWsPivKRiq-ghezB=hg+Fw@mail.gmail.com>
 <CACGkMEuqGtJP3vXoHrXOBgvPz3woo900+U9kYX1xZnM5h_qXWg@mail.gmail.com>
 <03c8f7ca-8235-a5a7-5367-b6fd59ad0447@nvidia.com>
 <CACGkMEv3XBXB_i_PUwxgvY8_UWipGVu8xuGQATp+kHOx3Vdnsg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv3XBXB_i_PUwxgvY8_UWipGVu8xuGQATp+kHOx3Vdnsg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ

On Thu, May 11, 2023 at 03:20:52PM +0800, Jason Wang wrote:
> On Thu, May 11, 2023 at 12:08 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> >
> > On 5/10/2023 12:22 AM, Jason Wang wrote:
> > > On Wed, May 10, 2023 at 11:51 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > >
> > > Just to make sure we are at the same page.
> > >
> > > 1) if the hardware has configq and we need to make it work for current
> > > virtio-pci driver, hypervisor needs to trap guest PCI access and
> > > translate it to configq command. This means the hypervisor needs to
> > > hide the configq from guests. In this case the configq needs a
> > > dedicated DMA address which is what PASID can help.
> >
> > > 2) if the hardware can report the device states, unless we want to
> > > migrate L2 guest, hypervisor should hide it from L1, so PASID is
> > > required to isolate the DMA for guest traffic and device state.
> >
> > A configq negotiates + discovers new fields for the PCI PF, VF, SF/SIOV
> > devices over PCIe or other transports.
> > So no need to hide/mediate for hw based devices, like cvq and like data vqs.
> 
> As discussed, I may misunderstand the function of the configq. If it
> works like cvq, then yes. We don't need PASID.
> 
> But if we want to report device state via let's say migration q, it
> requires PASID since it is used by the hypervisor.
> 
> Thanks

I don't exactly get this part. With SRIOV migration q normally would be
part of the PF, accessing hypervisor memory.





> >
> > For vdpa kind of use case it can work like cvq mediation, which I
> > believe is happening without PASID today.
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

