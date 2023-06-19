Return-Path: <virtio-dev-return-12984-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FF2EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 18:00:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 066B114E6B2
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 18:00:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC61E986509
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 18:00:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC7009863A6; Mon, 19 Jun 2023 18:00:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C8E7C9863B0
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 18:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bBJaFqw5NDmmgFX3nXjf_Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687197642; x=1689789642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EH8FKleXz3QACMmTrr7uV3EjktQgRjwYCgC/1NJMKKQ=;
        b=Aif2k/bI9YdJ/CWuv+a35WspE7UVSqgBLmFfcB+UN9tZCWtOiOJlTI9jcFj7lcDy6h
         KQaAunJYBpynIq4Gd95U982PmF16CiRFUeNX47Dk3netDVMjjxCslgPZsB6GXiVh9PfH
         xQAlA0npsZtOHxmkkguBDnK+7/Ze/hC2q9TfafCF+LBD+AJEyIy3VulJou4JYddqTvh2
         Ccoq9sdigTbtWa0LUjuy1agRaQJiPieNjrtATnEmqAy2oCcg79u60a3ZHEgwRqz6Ku0o
         3UKzP4QuBrqznb8m3qYOxJTaTbrUMT/B7uMEq/0EKMHOSnPMecxMlVhBe+86a0JN0uJM
         8S5A==
X-Gm-Message-State: AC+VfDxhLpWhHHRjNRbDsBzb2bShjGIW2A7b36IF+ecpIrHouzGkLxk7
	Rxf+OKFvARU6ig4mTU6B3KlHQnwivcX20iLzQJTq2U8x6aHieSxe0NmnehYu2DFhfHaNZoCeMPd
	ufRzzwOQOcouHgyjAw7Mw39JZ8ppS
X-Received: by 2002:a5d:69d1:0:b0:30e:2ff3:8c88 with SMTP id s17-20020a5d69d1000000b0030e2ff38c88mr7243835wrw.35.1687197641968;
        Mon, 19 Jun 2023 11:00:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wE68oxVGzmD3mod4fDviifeAjck/tbmtD2OGt1uPTQtoWZhW+nY4B2Of3XCh6XfSdoJKwrg==
X-Received: by 2002:a5d:69d1:0:b0:30e:2ff3:8c88 with SMTP id s17-20020a5d69d1000000b0030e2ff38c88mr7243825wrw.35.1687197641695;
        Mon, 19 Jun 2023 11:00:41 -0700 (PDT)
Date: Mon, 19 Jun 2023 14:00:37 -0400
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
Message-ID: <20230619135750-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access

On Mon, Jun 19, 2023 at 05:45:17PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, June 19, 2023 1:38 PM
> 
> > > > If we can't just make it come for free then maybe
> > > > VIRTIO_PCI_CAP_LEGACY_NOTIFY_CFG is better, we can just list the
> > > > number in the common section and then link to the description in the new
> > section.
> > > >
> > > How is it better? It requires burning more bytes.
> > > Is it better because it is self contained?
> > 
> > Mostly yes. But it also adds a bit more flexibility, right?
> > I thought avoiding touching transport-pci is worth less flexibility but if we can't
> > avoid that...
> >
> That flexibility is better gained via AQ instead of introducing new extended capability on the VF.

To be frank for e.g. transport vq we'll need to do it with admin command
(can we stop saying AQ please? it's a habit that carries over
when you write spec later. I know AC is a weird abbreviation though
;) )

So yes, if we can find a way to make everyone happy with admin commands
then it is better, for sure.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

