Return-Path: <virtio-dev-return-11511-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CFDC6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:59:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1A267370F3
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:59:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FCA4986702
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:59:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 042B89866F1; Wed,  8 Mar 2023 11:59:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6F089866F2
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 11:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yKLnk7mbMK6ZXMy3ddFLMA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvW/VMKf0nALOLhS69x0hM1ybM5cUqwc4a4UtIU4QxU=;
        b=WlslnNLsZHVC0ImCYzv2ZYLSY8g9Vn/zhqBgM9n/lI//zvKY0hW3bbheeCX5jaXJ9B
         Pf3NoT+NjDUwKTQdKaX/zfJUJe3NzABvd56DNDDp5ojV3LErL9CLMGx4xEsMAGkEmHVV
         DNyIW3KwI4uz/ylKV5GFnUYir+IzGj4ZEFFZAyZoJ0/hQbZtwC+fP/mvS8Z+n/bIZwxG
         1U3vB43WjwQXeyzf+VsRKv/N+2PVAy9uRXDi9xc1GdXPvsGmXCSThX/Ud9AGwj8Q8F3W
         FMh0qjOqrAiS+JK6KaSjtNL/yq+U9GAvQ38/0x1sep42nHVCu0w8fMCxfYn1WFyAeV35
         xFHA==
X-Gm-Message-State: AO0yUKVDhnBkKAmSSzCSMcgvsn0nfv59Z2vTP368lKPh+7Ee1LlolQtf
	AD3HKA7DUkSECLXYgfQw9DkAaB/5esov7WfKLg1wdC+mCZ33hnKpB8KBHA7s0vizg+9Eg91eocG
	hY0ffI3/eraKfJSO2THOsOEmJDlvn
X-Received: by 2002:aa7:dd06:0:b0:4c0:c45:4b64 with SMTP id i6-20020aa7dd06000000b004c00c454b64mr15393015edv.31.1678276775323;
        Wed, 08 Mar 2023 03:59:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+qs1G3vmDaCnj7qwmjtNkWkEJ2+mBgnvzOc72Fch5AKBkfKkfaWL1xxMyzn1Sj0wgBkF31+g==
X-Received: by 2002:aa7:dd06:0:b0:4c0:c45:4b64 with SMTP id i6-20020aa7dd06000000b004c00c454b64mr15392987edv.31.1678276775062;
        Wed, 08 Mar 2023 03:59:35 -0800 (PST)
Date: Wed, 8 Mar 2023 06:59:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308065856-mutt-send-email-mst@kernel.org>
References: <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho>
 <20230307143911.GC124259@fedora>
 <ZAdTSiVJGSrRIqZ3@nanopsycho>
 <20230307190347.GA153228@fedora>
 <PH0PR12MB5481B78E6408C1A7C04FDABFDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvn+o1aJnyaWN58gxU6Y-xA3okkWYKcwfmg7ExdhOmv1g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvn+o1aJnyaWN58gxU6Y-xA3okkWYKcwfmg7ExdhOmv1g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio] RE: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10]
 admin: introduce virtio admin virtqueues

On Wed, Mar 08, 2023 at 01:17:44PM +0800, Jason Wang wrote:
> On Wed, Mar 8, 2023 at 3:09 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> >
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > Sent: Tuesday, March 7, 2023 2:04 PM
> >
> > > An alternative is unconditional out-of-order completion, where there are no
> > > per-command ordering rules. The driver must wait for a command to complete
> > > if it relies on the results of that command for its next command. I like this
> > > approach because it's less complex in the spec and for device implementers,
> > > while the burden on the driver implementer is still reasonable.
> > +1.
> 
> Note that this is the way current ctrl virtqueue works.
> 
> > This has best of both.
> > 1. Command ordering knowledge and hence the decision left to the one which issues them. (driver).
> > 2. Ability to execute multiple unrelated commands using a single AQ.
> > 3. stateless device in AQ command execution
> 
> Does this mean if we want to migrate AQ (not use AQ to migrate), we
> need to wait for the AQ command to be completed?
> 
> Thanks

As with any VQ, if you migrate while an operation is in progress
you need to figure out the internal device state.

> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe from this mail list, you must leave the OASIS TC that
> > generates this mail.  Follow this link to all your TCs in OASIS at:
> > https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

