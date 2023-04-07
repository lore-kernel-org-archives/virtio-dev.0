Return-Path: <virtio-dev-return-12061-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27415C77B61
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:44:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 039EF339BD
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:44:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1C9998660F
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:44:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD331983F7B; Fri,  7 Apr 2023 11:44:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 927F4986622
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 11:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: GbmVgFAcM7mbuTfnAzt1Ew-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680867887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd0McE1Pmqo31JqLuxc+//gxA8SQH8R9CaWWacnuXp8=;
        b=UkQCFqbK8m2FsJ7t4np2uZ8aIZRgQLEl0tJRHpSfKNIRntuCfJ1e3KZyYHqUdI/Ofz
         HcjBAtFin6MLQRxIyvho3j9tooFAQI6eQcfmz8UUaGvAdY4qjaMn4b5nCNVqEdgCa96u
         1psWefrK1yBcj0Vp6hSo1Dh0i/8a8cuKyZJljeFR7cw9IDrgZ5WI3ml6aedgnfX74DC1
         rv+mYDaEeo30WKQUnoYLRt/R6y4DXfqVHBMfFWMbsbvOwgCGwD3zLkrEPkwOphxnI6d1
         6eQybm/i4euZSHzFbgBUxVoDEo1/gqrs4kbzPK5g1XeYgiaYzbeJ0o8VPXrkzD3dhB43
         FljQ==
X-Gm-Message-State: AAQBX9f0g8i9EA2oKAseqz6VBN77SWZKq4QaFiGCdWH+Om+ZS50V5FK8
	0xcT/o0szgECKUmu+k90E3wS3v43NwM1AHAN1/pkFeOqPZDkHsx2u8A6g0ApkCu5spgH51XbWxl
	gB+tGgxVhIB1ben0rSk7xfdW2e9pU
X-Received: by 2002:adf:fac5:0:b0:2cd:de25:1c76 with SMTP id a5-20020adffac5000000b002cdde251c76mr1093069wrs.17.1680867887617;
        Fri, 07 Apr 2023 04:44:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZCWuep27lmMgceD/slFC9zf/Dl6W9HvGNiq4uDINBhc/4r5y6EUI/5+EaR8BcMmviMv2qc5g==
X-Received: by 2002:adf:fac5:0:b0:2cd:de25:1c76 with SMTP id a5-20020adffac5000000b002cdde251c76mr1093057wrs.17.1680867887320;
        Fri, 07 Apr 2023 04:44:47 -0700 (PDT)
Date: Fri, 7 Apr 2023 07:44:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230407074355-mutt-send-email-mst@kernel.org>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-4-parav@nvidia.com>
 <20230405012723-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v12 03/10] content: Rename confusing
 queue_notify_data and vqn names

On Wed, Apr 05, 2023 at 01:21:40PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 5, 2023 1:30 AM
> 
> 
> > VIRTIO_F_NOTIF_CONFIG_DATA is such a narrow usecase, I don't like burning
> > "vq identifier" on this. How about we just say something along the lines of:
> > 
> Ok. 
> > 
> > When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, this
> > notification involves sending either the virtqueue index or the virtqueue config
> > data to the device (method depending on the transport).
> > 
> > And then "the data sent is a device supplied virtqueue config data".
> > 
> Sounds fine. I will reword it.

FWIW I like this more than coming up with a cookie term, it is definitely a
more conservative approach.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

