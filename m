Return-Path: <virtio-dev-return-12267-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54FEC77B72
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:09:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E26E3603F0
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:09:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 98625986434
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:09:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 87A6F9863D9; Tue, 18 Apr 2023 01:09:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 738C998669C
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Apr 2023 01:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: R7mn5pSSO7aAEXG_52KaSA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681780180; x=1684372180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIjBmB22Id2Kqr5ZlkoNTbHFtOm6iFNBFqaO4ORYTV8=;
        b=OHDlgdpXInpTP41TGeMW4K3B77m5ozPzoeiP7iVPtSv5IeFba6Q3JBMm6BPMBnZD/f
         twSkZM3175ISBETUwBPCDDRoZATzYOifvn6E5TSqCrao6uDnOrbL4sVS2epZql4W8Gn5
         98kjYbDfyvfJxxQhEotWf/F2z4WA5MZHh6LCkk67315jGfmL8hL6pCXJ4bqh2lrMNu55
         r2BgWyOdXk769uO1QITHJi+w7+qi5zpIosgc05TSni42SIi3816w6A7UMUGLNVgPTCvD
         lOCGz/C9v56onDzlMI4qbXzZ7nRVzh6cvLvJTDJ2nt0ixLJXm+IuK4SgnsqK4QyjpuGE
         TzUw==
X-Gm-Message-State: AAQBX9e4pEgUbTrf/5cFLz4/F1DSFv1VQOChTimU/DckIhFTk41/eR95
	EAcTLuzr9SDT9ZoTaL1RD4qswVAZeW2pvIAc77NOJt/QR1PV2gAdFLqfl6/nfE+0R94CEWFWL3J
	CUJRkKzSybV1wimWYfGy/if1XEsQIgEL+GtkbIt6nF5M4
X-Received: by 2002:a05:6808:1820:b0:38e:8cf:b1d6 with SMTP id bh32-20020a056808182000b0038e08cfb1d6mr202186oib.3.1681780180382;
        Mon, 17 Apr 2023 18:09:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y5186As3adoBSjM0ODuGJUEPSe1JJAz+a+LKjsTn/gsnTFW/c+7xFrzRRPjk9hNCtXtzC8s3MNpswMVdn5jgg=
X-Received: by 2002:a05:6808:1820:b0:38e:8cf:b1d6 with SMTP id
 bh32-20020a056808182000b0038e08cfb1d6mr202177oib.3.1681780180151; Mon, 17 Apr
 2023 18:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com> <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com> <20230413163216-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
 <PH0PR12MB5481EEEE5BFE68CDC6628455DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230414025523-mutt-send-email-mst@kernel.org> <PH0PR12MB5481F9D94282F794E0A08BF0DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230416163929-mutt-send-email-mst@kernel.org> <PH0PR12MB5481AD9D5B6052C39A946AADDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481AD9D5B6052C39A946AADDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Apr 2023 09:09:29 +0800
Message-ID: <CACGkMEvV-2P4-7JzrDNCNzasG_S6pTYw==OZRd-dcsENL2aYzg@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Yan Vugenfirer <yan@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Tue, Apr 18, 2023 at 12:59=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, April 16, 2023 4:44 PM
> >
> > On Sun, Apr 16, 2023 at 01:41:55PM +0000, Parav Pandit wrote:
> > > > From: virtio-comment@lists.oasis-open.org
> > > > <virtio-comment@lists.oasis- open.org> On Behalf Of Michael S.
> > > > Tsirkin
> > > > Sent: Friday, April 14, 2023 2:57 AM
> > >
> > > > Do you refer to the trick Jason proposed where BAR0 is memory but
> > > > otherwise matches legacy BAR0 exactly? Is this your preferred solut=
ion at
> > this point then?
> > >
> > > We look at it again.
> > > Above solution can work reliably only for a very small number of PF a=
nd that
> > too with very special hardware circuitry due to the reset flow.
> > >
> > > Therefore, for virtualization below interface is preferred.
> > > a. For transitional device legacy configuration register transport
> > > over AQ,
> >
> > I don't get what this has to do with transitional ...
> >
> Typically, in current wordings, transitional is the device that supports =
legacy interface.
> So, it doesn't have to be for the transitional.
>
> I just wanted to highlight that a PCI VF device with its parent PCI PF de=
vice can transport the legacy interface commands.
>
> > > Notification to utilize transitional device notification area of the =
BAR.
> >
> > The vq transport does something like this, no?
> >
> Notifications over a queuing interface unlikely can be a performant inter=
face because one is configuration task and other is data path task.

Note that current transport virtqueue only allows the notification via
MMIO. It introduces a command to get the address of the notification
area.

Thanks

>
> > > b. Non legacy interface of transitional and non-transitional PCI devi=
ce to
> > access direct PCI device without mediation.
> >
> > So VF can either be accessed through AQ of PF, or through direct mappin=
g?
> Right. VF to access legacy registers using AQ of PF and continue non-lega=
cy registers using direct mapping as done today.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

