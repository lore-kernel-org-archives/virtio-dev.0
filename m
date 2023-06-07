Return-Path: <virtio-dev-return-12878-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A822BC77B7A
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 08:54:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EF91B42A6B
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 08:54:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1550986660
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 08:54:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B6F4898664C; Wed,  7 Jun 2023 08:54:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A17D5986650
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Jun 2023 08:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qcf8bC3zPoGQghEdyA3pIw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128045; x=1688720045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mc5+jcBo5QHTAr/wig1xQu7FvVMd3URiYk8kDGkK1VY=;
        b=G+O5Psn/SDMs0YAoafCyqpLuZZruyuIysj4/eP6XgRpjM1pSLyvkk7EE8I0UIbRme/
         2mEdceSNgpzAuNBmNbvGwkMN5jGhlhAB3Oha4VrbuqUDFbgsz8eWyS6c2yBYZdy+qt9D
         wDVIQ9CqhSlgn1nRqQkX491ppGWKj/v8vMWVFUXIDAy3sMefZ43Q9Loxdk5mdliGY1TQ
         tgf/WWDkxAHrwgJuSAulCQDOPnRpazIC+oUJNw8cx7yCn8L55kz8GSQ4TFMLGhgSv3Ua
         A2QWEWZYl4azcg/4CF83tyggp5YRHHWsFdERLmS+IdrpcaE30xqbYStmi/CMBIz8eFDx
         UGrA==
X-Gm-Message-State: AC+VfDwFf4/LhG9krs7KIKpNkOc5K30/a5Mm0O1XtlB504cZKRLTx/cg
	dGgLjcVmwBObXh7IdcQvghJ5fZI+032yu92zFhm84XuyoE5cCXLQKl9Y8/+O/opJvwhaFDs4Y9t
	67NS3baw/H+UIbRq0+FX7I4+bDifz
X-Received: by 2002:adf:df04:0:b0:30a:a715:66c8 with SMTP id y4-20020adfdf04000000b0030aa71566c8mr4018771wrl.8.1686128045499;
        Wed, 07 Jun 2023 01:54:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5sOlmVWEcM5SCoi1qlMfc6sNj2HHTIjxp6vEuCdY05ZCLUHBzfxoiCpHwsSwTch/zgJWH4EA==
X-Received: by 2002:adf:df04:0:b0:30a:a715:66c8 with SMTP id y4-20020adfdf04000000b0030aa71566c8mr4018756wrl.8.1686128045145;
        Wed, 07 Jun 2023 01:54:05 -0700 (PDT)
Date: Wed, 7 Jun 2023 04:54:00 -0400
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
Message-ID: <20230607045225-mutt-send-email-mst@kernel.org>
References: <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

On Wed, Jun 07, 2023 at 02:54:22PM +0800, Jason Wang wrote:
> On Wed, Jun 7, 2023 at 11:06 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Tuesday, June 6, 2023 10:27 PM
> > >
> > > I can't say I like this. I prefer to do meditation on top of a modern device with
> > > some lightweight features like _F_LEAGCY_HEADER. I don't see any advantages
> > > of a new legacy ABI over _F_LEGACY_HEADER. I don't want to repeat but I don't
> > > get any response here
> > >
> > It is net only and not generic. Not a big blocker.
> > It doesnt stop at _F_LEAGCY_HEADER.
> >
> > > Anything that prevents you from adding things like VIRTIO_NET_F_LEGACY_HEADER?
> > It requires hypervisor to mediate 1.x config region and intercept feature negotiation including q config and more.
> 
> For config region, do you mean device configuration space or common
> config space?
> 
> I don't see why we need to do mediation on neiter of the above.
> Hypervisor just need to prepare
> 
> 1) legacy BAR with legacy config and device configuration space and
> 2) modern BAR with modern capabilities (common cfg and device cfg)
> 
> For 2) it could be mapped directly to the modern capabilities. For 1)
> hypervisor needs to mediate
> 
> >
> > Additionally, 1.x device says the mac address is read only, while legacy is RW.
> > And that requires yet another feature bit negotiation.
> 
> Hypervisor can trap the legacy device configuration space write and
> convert it to cvq commands.
> 
> Thanks

Hypervisor really can't access cvq if guest is doing it too -
that requires emulating cvq in software. And *that* is going
to be broken for workloads such as confidential computing.

> >
> > The main design goal is to not mediate 1.x specific region and not modify 1.x region definitions.
> > Which is why we step forward with the AQ.
> >
> > > https://lore.kernel.org/virtio-
> > > dev/CACGkMEuixsBibSq_pEQvcKOH0WBQWnta4Q2c28SV8qTS8gaVcA@mail.g
> > > mail.com/#t


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

