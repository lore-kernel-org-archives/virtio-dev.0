Return-Path: <virtio-dev-return-11408-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8ADC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:51:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EEB3A76044
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:51:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E70F29866F9
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:51:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC831984091; Thu,  2 Mar 2023 23:51:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC8069866AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 23:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: e7-rPo_yPnyQZhxkqUMYaw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iq9xTZbBR9sQU0wL63uyfTLl5YeTqV0p/GfQDRdWIY=;
        b=oXgpgsVFZ1uwFok/uZviGDFEelSb9sbULzSwosnaPb8doBjweSPhpfg8TBRxCM0X+n
         eEYRe/OAwrnGAQX4VxvQdE+W5xyhAHaQSmDiWbTLWGdpwDaXLy6gsXGaCTHtlBHVAsVr
         dfpz73K+LfHRMumkbnxdWkEjAB3/b4/Neqh5/Ob2ZRM7SwRFJSHrVqVCBr7jSx5thpP6
         P+V45EKy9uhu+zRK876p8KRwmv7PhfSuXJ4OKje1Iyzeig614Wjh36oo3bFe08sAKml2
         y1Y23eQ+NcBFnaAulHb2yNSBRWoR3ejJAuQLLrIXZOUa1w+OZS2uHrtiXY0wEITpLdgC
         cDMg==
X-Gm-Message-State: AO0yUKUhsBOQ8i0uuCpDt8roB5w18P0iW+W9WD93pRzk7f8oCarnuiOD
	VdAGNC9Od5+UZW8zArNgP30do+TkO4Gm4E5RCa4DOervBi9od8V4NVAfbOET1xF/PR96Vn97OwS
	oooIyNRRnAFniblDvEEnXx5LzRfA2
X-Received: by 2002:a5d:4290:0:b0:2c9:2917:4e29 with SMTP id k16-20020a5d4290000000b002c929174e29mr61098wrq.27.1677801091931;
        Thu, 02 Mar 2023 15:51:31 -0800 (PST)
X-Google-Smtp-Source: AK7set8rsTBU4yGfZ0PNujHMWNXMyOPQiROK8AmqK6X1ajHjiDtiLltYcWQZO/uMiUtrqKgqGlLsrQ==
X-Received: by 2002:a5d:4290:0:b0:2c9:2917:4e29 with SMTP id k16-20020a5d4290000000b002c929174e29mr61082wrq.27.1677801091581;
        Thu, 02 Mar 2023 15:51:31 -0800 (PST)
Date: Thu, 2 Mar 2023 18:51:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302185118-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 06/10] mmio: document ADMIN_VQ as reserved

On Thu, Mar 02, 2023 at 06:40:55PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, March 2, 2023 8:05 AM
> > 
> > Adding relevant registers needs more work and it's not clear what the use-case
> > will be as currently only the PCI transport is supported. But let's keep the door
> > open on this.
> > We already say it's reserved in a central place, but it does not hurt to remind
> > implementers to mask it.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Did you miss reviewed-by from [1] or this is an old series reposted?
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00242.html


yes I lost it.

> I will wait for your response before reviewing more, as I am confused now between missing items of v10 of Feb and March.
> 
> Can you please have the per-patch change log? I learnt and practice that from netdev community.
> It has been very useful to have effective reviews (especially when series is long).


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

