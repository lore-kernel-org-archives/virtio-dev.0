Return-Path: <virtio-dev-return-13933-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FC3E7D0C2
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:32:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A12842B026
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:32:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 826A59866B1
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:32:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6667F9864C1; Fri, 22 Sep 2023 03:32:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 528A998669D
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Sep 2023 03:32:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: FTwIhfWrMNqNOfJ3OtYAwQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695353531; x=1695958331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/uiil81b7WTdODsPoywpgM50GSWAZhQLRUgFFkdQD8=;
        b=jqgtvF2UikwG5N//K3mXjOcehxBHUimwHU/8PI5i7xaj0flT9zO4gmRQD0itcub7bp
         Te6or7vW+HbsEl3xQ/+qh2Mw6RZJZFx3rI0Yca5T7xDCNOrRxgoVPMPOJoSefueFcIYf
         d/3Nzekn/nEnLzYflYtu4Hhc/nSgH/+jLmnaw1TsnIZmZsBnsHiWRpDsKkRR8wZWvHSH
         CnbPbQNFDpWbR/ulHkzVl0uEY89293gMY09dg3f3f8jM2PA8aQ5j3CTk/bImPnW+4egZ
         ljGpq5L4vOwskL7JTgup7hCfMkjoM0txTybL2n+rI1adiGG+KeVe+jFtSl3elo1xfdI2
         TqAA==
X-Gm-Message-State: AOJu0Yybom/OVvSiIa5DlPn3E3E/gajSHiRbq2F/th1LW92hSDWUl14H
	UNuwtx8uv5V6YSRfPKHr4BOdGHWndTy7WRGqyL6zf0cAYqFmNQS8Hw2/5m0WYlYMs1SM1fSuytz
	8mAJ58jvVTA60Mk/6mrgzHnYgLggioPVVxnQOxLs9twbC
X-Received: by 2002:a05:6512:513:b0:500:9969:60bf with SMTP id o19-20020a056512051300b00500996960bfmr5855600lfb.68.1695353531081;
        Thu, 21 Sep 2023 20:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFMtw2f1Kh6jz54o87W1B6rJh7TeSPd1VKfYNOpoy7hV6sdxvjaAqgFU+rL3E0siONeo4yp2LswIXfl7gna+g=
X-Received: by 2002:a05:6512:513:b0:500:9969:60bf with SMTP id
 o19-20020a056512051300b00500996960bfmr5855594lfb.68.1695353530793; Thu, 21
 Sep 2023 20:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org> <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org> <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org> <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921040133-mutt-send-email-mst@kernel.org> <PH0PR12MB5481F59CBD9B2B615D6F4B0EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921060320-mutt-send-email-mst@kernel.org> <PH0PR12MB54819A286CA557DD654E7BA6DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54819A286CA557DD654E7BA6DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:31:59 +0800
Message-ID: <CACGkMEtABcrdEMwYZtipqm5RxSwuSNHJyX6o8_hs==Hea2HG_A@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Thu, Sep 21, 2023 at 6:39=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, September 21, 2023 3:40 PM
> >
> > On Thu, Sep 21, 2023 at 09:17:53AM +0000, Parav Pandit wrote:
> > > Vdpa stack make total sense when the underlying device is not virtio =
and
> > hence emulation.
> >
> > Which linux framework is used is kind of beside the point but since you=
 bring
> > this up - not necessarily.
> >
> > E.g. I personally don't care much about "stack" but clearly we need a v=
irtio
> > driver on the host to be involved, teaching vfio about virtio is probab=
ly a much
> > worse idea than creating a mode in the vdpa driver which mostly sets up=
 the
> > IOMMU and otherwise gets out of the way of using the VF and just drives=
 the
> > PF.
> Well, vdpa has to drive large many things including cvq, config space, ms=
ix and more.

Just to clarify, vDPA has the flexibility to decide if it wants to
deal with the above not (except the MSI-X which is hidden in the vDPA
layer).

That is to say, if vDPA wants, nothing prevents vDPA from assigning
CVQ and config space to guests.

> It can help to overcome some issues as you listed below.
> So that way vdpa over virtio is useful.
>
> In vfio world, there is nothing significant to teach about virtio.

It would be pretty fine if it's nothing, not nothing significant.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

