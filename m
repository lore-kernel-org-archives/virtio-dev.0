Return-Path: <virtio-dev-return-13194-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE8CEB64DA
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 15:30:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 507242AC4E
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 15:30:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4725E9866FA
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 15:30:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3A3799866ED; Fri, 30 Jun 2023 15:30:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21BFC9866F2
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jun 2023 15:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: i9bg7kfzNva3_n_hQ7_W3g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139041; x=1690731041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbr7zYObTvs0TeBGE3x2raUKjljJoCtso/F/Z3AaHE8=;
        b=ILhuMR0ciA1L87UqNPpdkfUbJKErm5wJliPqZikuJYr3ilOxxVuYoLbckqkXFlUPD8
         nplxnVZLeWfsAojcLBKmXEvnnx0qHwHJYbf28W55qJE3srXMvD+wD/OGb/A+1lgYfdpN
         8flMre81zSxJiJddSKxxL9PlXLKqioIACNNCBtvEtdhzqE3juV29tLIGfGXB70N74caj
         P5Yk1dVIy6TxMlH35NGucBBauGtERyckjtcORlxiY42tzV+CEINUsUhA8UxPE/S6Fa+r
         xtVdcMdJtDmXdgSrCWilZmg2sfXnWnJZz8o48+/1oX+DywoqmSpqnztmuvmpjH4lkOPe
         sFbg==
X-Gm-Message-State: ABy/qLYW+aCJGSlIuhS89vEpdfONIGJD6Nq5Zk3PRJBN3G4tw+fmSMo2
	UjOgUmLkHWaMomb+ZArcc9wrgD/qtyT95cM0UtirKgC8rSGwFq7Bz1z0p30nhRV4RiVdS6H841S
	n3+LoJbTLPkEpzMdOrygy8WDNIjA7
X-Received: by 2002:adf:fa88:0:b0:313:ec90:ac23 with SMTP id h8-20020adffa88000000b00313ec90ac23mr2340533wrr.13.1688139041026;
        Fri, 30 Jun 2023 08:30:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGoOD0FD1Xt9r+9jrQnPO489xyJMcCpTzg8ZBFWiCq1irmw870o4VZX/9ggKsZfwaRMHl6s2Q==
X-Received: by 2002:adf:fa88:0:b0:313:ec90:ac23 with SMTP id h8-20020adffa88000000b00313ec90ac23mr2340521wrr.13.1688139040741;
        Fri, 30 Jun 2023 08:30:40 -0700 (PDT)
Date: Fri, 30 Jun 2023 11:30:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230630113018-mutt-send-email-mst@kernel.org>
References: <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628132122-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628152125-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629030345-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548107B410662A97A3BD1BEFDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548107B410662A97A3BD1BEFDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] RE: [PATCH v19] virtio-net:
 support inner header hash

On Fri, Jun 30, 2023 at 11:38:49AM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Michael S. Tsirkin
> > Sent: Thursday, June 29, 2023 3:07 AM
> 
> > > > Well SHOULD also does not mean "ok to just ignore".
> > > >
> > > > 	This word, or the adjective "RECOMMENDED", mean that there
> > > > 	   may exist valid reasons in particular circumstances to ignore a
> > > > 	   particular item, but the full implications must be understood and
> > > > 	   carefully weighed before choosing a different course.
> > > >
> > > RECOMMENDED and SHOULD forces the device to support MMIO, which is
> > not good.
> > 
> > You said this already. Let's not repeat ourselves please.
> > 
> > It's a single word. We need to work on a patch, we can argue about small detail
> > once it's posted. It's not in your list of plans so I am guessing we need someone
> > on Red Hat side to work on this?
> 
> Yes, I prefer to work together and before writing the patch.
> As just DMA for config space is only point fix problem.
> So lets discuss in new thread and improve this for config space and also other limitations (like support multi-address VQ).
> 

Interesting.  What is multi-address VQ?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

