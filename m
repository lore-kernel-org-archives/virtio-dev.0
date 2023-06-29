Return-Path: <virtio-dev-return-13144-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF9BEB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 07:07:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A02F6EEA07
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 07:07:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8415D9865E1
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 07:07:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 649439841AB; Thu, 29 Jun 2023 07:07:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50B29986590
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 07:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2j4nWJK1OVmfxBTIKeHZXg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688022433; x=1690614433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNizIK8kauGtncuBxmot7fuS9Aqv+C+YOlo+k9Id4+A=;
        b=IwdC4/zbdfRG6cEFZoExnj33PuoOU1k413i6lI6antzKMZZy8PGfqYHxS6GMx1vd55
         qEyfbycmguH1DzQw1E1714AaLHysh61/uhHr/8QRPK/BrjS8tdPktHW/XnP0qkBoQ+8f
         jI3sqpncOh1tjudco0ZByitzhEvWbPAOqXWLuCANeOQA3rXafZq18+scmZAxXyUUCo1c
         GrbyF/lvUOWUvScIQE/aBBfiicr8EC+b/lxwMNToI5jhl3UWZWF/HE78lDdUlmRvs2vE
         yMulRwuHnAq5g1yFFyXZ1AjKZJ1LJAruTjpLN2KhnizJL6YOQ/xrcBZm+/oEmp+GUMBL
         ss5Q==
X-Gm-Message-State: AC+VfDzEkxuKDuWsVv5TLS0pmIYFE/R3v19KhSnzyYa/zwQsgL+q/Msu
	cQK3jq+isTIZzKbIxxjTgx9HTwWmCO7dcjLujx7NVAvXaby/8khoF8F7l0ntMb28MfgpxrF8g53
	zxxdAAmCuS9dmFmuogIeQxfb69FZ7
X-Received: by 2002:a05:600c:28c:b0:3fb:2d92:ecf1 with SMTP id 12-20020a05600c028c00b003fb2d92ecf1mr3301658wmk.7.1688022432891;
        Thu, 29 Jun 2023 00:07:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75r+i15bn91Izq0emlEYhr/YrsdTiII7j8lNvHpBOtV6E9Ze4OsAtrD2QOOeKE8ZH29nwRDQ==
X-Received: by 2002:a05:600c:28c:b0:3fb:2d92:ecf1 with SMTP id 12-20020a05600c028c00b003fb2d92ecf1mr3301643wmk.7.1688022432518;
        Thu, 29 Jun 2023 00:07:12 -0700 (PDT)
Date: Thu, 29 Jun 2023 03:07:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230629030345-mutt-send-email-mst@kernel.org>
References: <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628132122-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628152125-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash

On Thu, Jun 29, 2023 at 01:56:34AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 28, 2023 3:45 PM
> > > > Maybe I get it. You want to use the new features as a carrot to
> > > > force drivers to implement DMA? You suspect they will ignore the
> > > > spec requirement just because things seem to work?
> > > >
> > > Right because it is not a must normative.
> > 
> > Well SHOULD also does not mean "ok to just ignore".
> > 
> > 	This word, or the adjective "RECOMMENDED", mean that there
> > 	   may exist valid reasons in particular circumstances to ignore a
> > 	   particular item, but the full implications must be understood and
> > 	   carefully weighed before choosing a different course.
> >
> RECOMMENDED and SHOULD forces the device to support MMIO, which is not good.

You said this already. Let's not repeat ourselves please.

It's a single word. We need to work on a patch, we can argue about
small detail once it's posted. It's not in your list of plans so
I am guessing we need someone on Red Hat side to work on this?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

