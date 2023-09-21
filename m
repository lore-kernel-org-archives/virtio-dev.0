Return-Path: <virtio-dev-return-13926-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FDAE71060
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 12:23:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6D3152AD50
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 12:23:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4858D986692
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 12:23:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2F6E4986687; Thu, 21 Sep 2023 12:23:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20FD2986688
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 12:23:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 20x8PoK9M2e4AihkxSEYAA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695298979; x=1695903779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF1ApKrhIgJvjeVr19Db0oJd54LfuaRTZ1isIXIdbB0=;
        b=WrNXcgscDa0iWbWq3KKeGUP4mMrItIcJb5/HYU/27bjoTd/jqNivX36SbK598c+9dS
         pzGaRjJ2IakbC4rQOy8TF1cyp79Rd/fWBw+zehGEFpssajXPa4sKY1IQHSTpJbqEF5Zo
         CASqwVon04qhBpnTLLgJrBlMQbZCMI43cKbcE83CdzrOeKceiVomgD83luRJlE2Sr5QQ
         oPpLOIG07i9QYg1DJtOowXfuQP/SG6/gz2sWKXduWeMPrEdVKfsm+O76SZEw1NgsSERF
         ETVhBmLG7gd22rgdVO3X0WySSreR38Vp/yiM/OVwUz1KaqQAgyrkqrk5FGnmyPLLzuAs
         g7Vg==
X-Gm-Message-State: AOJu0Yyyu0/s6IQ29apqSmxDTU01Bt8t2u1RA4VfzYndgnWwTCCASle5
	ZrPAIuuaI1XMyEL3KPkZZOFvGxR4zoCiP3snzQq/7H+iAR1qtk5w6NKL3GFkIJRC+0upSVV1VCF
	qqH2FTA35ZCHYBMYE6WRQhchBe3wh
X-Received: by 2002:a05:6402:5242:b0:527:1855:be59 with SMTP id t2-20020a056402524200b005271855be59mr11598606edd.3.1695298979425;
        Thu, 21 Sep 2023 05:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0VPchgSuHqndRdRSmMRmaYlGJKBXcxYhAu/7fILYH8s0sOjvKqsuhwAirmk3u/BAlwOP08g==
X-Received: by 2002:a05:6402:5242:b0:527:1855:be59 with SMTP id t2-20020a056402524200b005271855be59mr11598594edd.3.1695298979130;
        Thu, 21 Sep 2023 05:22:59 -0700 (PDT)
Date: Thu, 21 Sep 2023 08:22:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230921073101-mutt-send-email-mst@kernel.org>
References: <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921040133-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F59CBD9B2B615D6F4B0EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921060320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819A286CA557DD654E7BA6DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819A286CA557DD654E7BA6DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Thu, Sep 21, 2023 at 10:39:23AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, September 21, 2023 3:40 PM
> > 
> > On Thu, Sep 21, 2023 at 09:17:53AM +0000, Parav Pandit wrote:
> > > Vdpa stack make total sense when the underlying device is not virtio and
> > hence emulation.
> > 
> > Which linux framework is used is kind of beside the point but since you bring
> > this up - not necessarily.
> > 
> > E.g. I personally don't care much about "stack" but clearly we need a virtio
> > driver on the host to be involved, teaching vfio about virtio is probably a much
> > worse idea than creating a mode in the vdpa driver which mostly sets up the
> > IOMMU and otherwise gets out of the way of using the VF and just drives the
> > PF.
> Well, vdpa has to drive large many things including cvq, config space, msix and more.
> It can help to overcome some issues as you listed below.
> So that way vdpa over virtio is useful.
> 
> In vfio world, there is nothing significant to teach about virtio.
> Vfio is already has the model to extend the stack to do only specific work and reuse the rest.

Again the thread has been side-tracked, which linux module does what is
not what it was talking about.  By the way I wonder who decided to drop
virtio comment from this and copy virtio-dev. Guys please don't do this
and generally just send spec patches to virtio-comment, implementation
discussion on virtio-dev.


> > 
> > But for example, to migrate cross-vendor you need the pci config space to look
> > the same and for some devices this might mean that pci config space will have
> > to be mediated.
> > Or maybe not. vdpa is a good framework in that it gives us flexibility, it is not
> > opinionated.
> 
> Sure, as you list, both has its pros and cons.
> So both solutions has its space and trade off.

You can thinkably write a vfio based driver for PF and VF in userspace,
sure. But I think this is just making things unnecessarily complex
for users who will have to know which device to use with which
driver. I think that e.g. if we have two ways to submit admin
commands, vdpa can just support both of them and that is all.
When mediation is not needed then vdpa will just get out of the way.

> Hence, if both can converge to same set of commands, => good.
> When there is different way two stacks operates for those items, we will have spec extensions for both model, right?

My intiution says a modest amount of duplication isn't too bad.
E.g. I can see two ways to submit admin commands as being acceptable.
Are the SUSPEND bit and vq state as defined by these patches acceptable
in addition to vq commands as defined by your patches? For sure
it seems inelegant to say the least.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

