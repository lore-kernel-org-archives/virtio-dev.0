Return-Path: <virtio-dev-return-11514-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91821C678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:08:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D37F62B146
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:08:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA11A9866F6
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:08:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 900189866ED; Wed,  8 Mar 2023 12:08:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C22E9866EE
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 12:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BTHTTvZrNXOdBaIMv_iDJQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678277280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kV3eaosM32PaJtiJFF8/FEFx7HUYYwdq10zoXNi4wI=;
        b=A+mo1KKR7SeHu1ipnQXqD4pfkwR2VqW513B1scTkbFBPUxyNdQlMJUlgjh+Vm2zs/r
         NBZi58TYbuY+xBC6htMqvVFecfmODoktlNSOV6gcD5bJFPRbQkhI8lzxJHWTK6/ZwczM
         pOSxgkskF4xqMgJrkY5aVZ1WLzVmniwWh4WtwzKl4ClEM1EdB7eFwYdIFwikWVpuyndu
         tlMikHji0Mh8gF92g1SlZ+FHxkiMAQjBj+Yvm+Lf5QnBAR8oLtwtVxOW7T7rFgVsvGNo
         /1Z8SseQe58GKyt6DGJaHgBHN9QMLwfWoQnX+Ja5gIosNyiCHS8z+Kn5OzEmHf4+4L8P
         Cv9A==
X-Gm-Message-State: AO0yUKXv5P+wm6ozV7vpAbwcbToz9kFmPkzaOEQ0PhEQD8tnvgWCDGEh
	hpIlKm+k/i42b/fQ+YCDywd1jkLiFmg6FH5+V970bSDPpuwhPrr1UwMPGER2MgPZi7LhKOJo8RZ
	7ggSPmwCywRQeemBzpxGZgT3j+Xlo
X-Received: by 2002:a5d:6e42:0:b0:2c5:4c9d:2dab with SMTP id j2-20020a5d6e42000000b002c54c9d2dabmr13606469wrz.10.1678277280613;
        Wed, 08 Mar 2023 04:08:00 -0800 (PST)
X-Google-Smtp-Source: AK7set8Rwp+X9ZUTp5w/nU2lIU9LfzTz9NapL0NKgGrsU4fCrNTMgXZ5NqmWhay2CqEYVKRk15s/MA==
X-Received: by 2002:a5d:6e42:0:b0:2c5:4c9d:2dab with SMTP id j2-20020a5d6e42000000b002c54c9d2dabmr13606449wrz.10.1678277280283;
        Wed, 08 Mar 2023 04:08:00 -0800 (PST)
Date: Wed, 8 Mar 2023 07:07:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230308070531-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302201912.GC2554028@fedora>
 <20230302185803-mutt-send-email-mst@kernel.org>
 <20230303131703.GB2866370@fedora>
 <20230303081900-mutt-send-email-mst@kernel.org>
 <4f869944-4ccd-c51e-0f30-dc3ba15ffd52@nvidia.com>
 <20230307192752-mutt-send-email-mst@kernel.org>
 <6668fd7a-3eb3-0447-9cbf-72d308b1336a@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <6668fd7a-3eb3-0447-9cbf-72d308b1336a@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

On Wed, Mar 08, 2023 at 12:55:37PM +0200, Max Gurtovoy wrote:
> > > 5. VIRTIO_ADMIN_STATUS_COMMAND_SPECIFIC_ERR (for more info read the
> > > command_specific_error field).
> > 
> > I don't think it's a good idea, we'll have to agree to disagree.
> 
> Ok.
> can you explain why isn't this a good idea please ?

Pointless complexity for spec, devices and drivers. In the end drivers
don't really do anything with all this detailed info.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

