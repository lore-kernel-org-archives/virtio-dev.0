Return-Path: <virtio-dev-return-12973-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6817EB64DB
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:20:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 139782AED9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:20:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5C84986428
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:20:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C49719863A6; Mon, 19 Jun 2023 17:20:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD1309863A9
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 17:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: XX2cztrxM_2ujSNJjVI2oQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687195194; x=1689787194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4m+16vHguMVMy0Pb/bvEk7lF31voKu/z5TT3sLZbXw=;
        b=RvQ3GV2cFn00fW/L4idJGlpHa/EbUIh1wz+ENDnLHtTWYgheH2qGRmzFZGwPHYFy0l
         vvynQKi2l9G8jw6eq5QyQ98Nm8cO1HiMCFSTFpOLqtwTstFKfQrTgmE4ujHzl5peVc+B
         trGus6qxjNadX5rhJ8tw5usZWYZaEEtQt2WGS9lIup/xB2WOQiCSWi6Asa9/G+zEf4VX
         7QxMp/p1DnMwkMHd9TiHrakIGu+PRccwVXrXyYgDppmKN8HFCaHDdG1ndGIB1M11le+V
         sVHA+AJxd9QPjRMqFE7nGNSxFAj6G1x37buPIRBQHJJn4tBs+lEnzRV8dG+xJK04AVcL
         Mr2A==
X-Gm-Message-State: AC+VfDwUdm6uhA3fjEjCWff1hWTZUrHEq57RnC8LGYqWwL2t/925YLHA
	7j6P8016lWBXfSbPUh0OUA28DBqmcXzGmNXw4aVyKLn2N8teoWIxM0PymsRSnWFBWOKAWFqj/dU
	RlhZswrvvdpfhMBTJBpCCHDCz+7+q
X-Received: by 2002:a19:5052:0:b0:4f4:b3e2:ff54 with SMTP id z18-20020a195052000000b004f4b3e2ff54mr6203466lfj.51.1687195194230;
        Mon, 19 Jun 2023 10:19:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ590fgarS4uUt6aOepzUPcbTbMxuk4pCuIt8VgnSypjUi56yuRapiZ6AwQOqjLQcLKjOpe5ow==
X-Received: by 2002:a19:5052:0:b0:4f4:b3e2:ff54 with SMTP id z18-20020a195052000000b004f4b3e2ff54mr6203446lfj.51.1687195193843;
        Mon, 19 Jun 2023 10:19:53 -0700 (PDT)
Date: Mon, 19 Jun 2023 13:19:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230619131115-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access

On Mon, Jun 19, 2023 at 04:39:16PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, June 19, 2023 12:38 PM
> 
> > >
> > > +\field{legacy_q_notify_supported} when set to 1, indicates that the
> > > +device supports legacy queue notifications at this notification
> > > +location. Legacy Queue Notification address is derived within a BAR for a
> > virtqueue:
> > > +
> > > +\begin{lstlisting}
> > > +        cap.offset
> > > +\end{lstlisting}
> > > +
> > >  \devicenormative{\paragraph}{Notification capability}{Virtio
> > > Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification
> > capability}  The device MUST present at least one notification capability.
> > >
> > 
> > I was hoping that we can avoid touching transport-pci.tex completely, this is
> > why I wanted to reuse VIRTIO_PCI_CAP_NOTIFY_CFG.
> 
> It is reused, but it doesnt come for free.
> Do you want to re-consider AQ notify query command?
> Or continue as proposed in v6?


If we can't just make it come for free then maybe
VIRTIO_PCI_CAP_LEGACY_NOTIFY_CFG is better, we can just list the number
in the common section and then link to the description in the new
section.

I also feel we want ability to have such a capability in the owner too.
Would prefer including it now though I guess we can add it as an
extension.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

