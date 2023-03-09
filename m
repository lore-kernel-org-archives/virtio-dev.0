Return-Path: <virtio-dev-return-11583-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A53BC742A7
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 17:14:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C89B33572
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 17:14:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97A8698670A
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 17:14:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8CA089866FB; Thu,  9 Mar 2023 17:14:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BCEC9866FD
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 17:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Hbaf6S56OXej85tLsl4TSQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjIVqJxjUfogqlFrRnS3zKQOJsTAc7Uy/n9PnZtsfFM=;
        b=8E4wvrJ3tG/559MqAIXiAvI+mtRAbM7cz17m9GEotBMISxBpcN5ARof26m3tIS/2m3
         TQI3YPVCN4asqUqxto83SZ8VAdP/LJY0A7EexKVZ0TQrzDrqqRkZHCMDjdL1S6NFu4z2
         8bL0WqpAXjm1biSJdia7mOETc0LRMR66UkdQfxG3LuQYOISnO6v1YRD0RaWQIxx1NNlQ
         dFUaz8+NgwTYdIGGzMkqYauVJp6iy7ga1/ajF9M24L2VTsgpe86Nu2hpV71ZCffZGN+E
         J96IrbXbnexfq4N5RA76nf8tPrBp/z7zXGsnVPoCa3wU5F/BVeyqFnvvqSTm7i7gDqzv
         RMlQ==
X-Gm-Message-State: AO0yUKVVAzimjZbyEM93EWx3u1tO02ns4YB3JMz2K5g4H97bmMgr+wC0
	KFpr52PgXAdUFMagDJ35MZrrsMinhrYbUt9VPiDGIvv/lUqPSmBETjIOOuFwLNHBvUJJ2dUV1pb
	mgV4ub6D0VF2xiIEHJXQHJMEQPJ0V
X-Received: by 2002:a5d:53c4:0:b0:2c7:11ae:9fd8 with SMTP id a4-20020a5d53c4000000b002c711ae9fd8mr14786227wrw.8.1678382047109;
        Thu, 09 Mar 2023 09:14:07 -0800 (PST)
X-Google-Smtp-Source: AK7set/2/PKsUsBwB7bagiyJ+MBQJtCBTx2vVhGigecASrxfwdlXky5JLFtOpss4pNn+za/6kvDADg==
X-Received: by 2002:a5d:53c4:0:b0:2c7:11ae:9fd8 with SMTP id a4-20020a5d53c4000000b002c711ae9fd8mr14786198wrw.8.1678382046822;
        Thu, 09 Mar 2023 09:14:06 -0800 (PST)
Date: Thu, 9 Mar 2023 12:14:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: David Edmondson <david.edmondson@oracle.com>,
	Jiri Pirko <jiri@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
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
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230309121313-mutt-send-email-mst@kernel.org>
References: <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmLIc97Ud09YfGT@nanopsycho>
 <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <m2mt4mxbt5.fsf@oracle.com>
 <PH0PR12MB5481FD2D2365CC08A5CD1E64DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230309091904-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548138694D606CE68B9E0C3ADCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230309094240-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548118B78312924C00EF14D8DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548118B78312924C00EF14D8DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

On Thu, Mar 09, 2023 at 04:53:59PM +0000, Parav Pandit wrote:
> Keeping my inputs aside for moment, what do you propose for v11?

Following SCSI and relying on driver to worry about ordering.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

