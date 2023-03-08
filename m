Return-Path: <virtio-dev-return-11497-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FDBC6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 01:06:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 341A96008D
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 01:06:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B8699866ED
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 01:06:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 19A8C984772; Wed,  8 Mar 2023 01:06:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 056179866E1
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 01:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cFBnaQaPNYK6fhJwh22nvQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678237579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/NOX4fXeGbT+btxfg/Qf0KHBrka3wo5x7t+sTIIWeY=;
        b=H+vajR3gSQKp0EckB/FlEFI5X8GGoFRk92XDnNLgTqMENhXMl3ztlzf527WPVlDL4H
         D70ozdu47sOTOLpN+R9AlOdL5vuvWEBiq+DdZTecSaW8wFO3PLCBI2L+uL+6dR/j1/+f
         VTkrYgYoGbG8e6c7c0KTcEm7S6O5xKdrXw2cJ+GFmY7/w3RUogYYZUtgnC18tYbh77rI
         RYHDF2NHdEvxepYhPaGMfle/8PPcub/OygUCSA48uo0uHHFrE6jrxAYeByWROfTTbMGA
         1YaK8Astad5fk1Psf9g1vL/nkIadX58/Cgif8GFA7iDhlTs40tWPbHhhF6UjNz6o7WpS
         lc3g==
X-Gm-Message-State: AO0yUKWfQIboBtfJLenDoMfkvBKHdQEIaduFUoz4kMzq9R1dz1b+oSOB
	OybEkWJgOHSj45VSb+VnvKQmQh/lxLwJEjnALpyYXbvAW0j10VDn5JoeFx5LOhE7p9KEca/hqBP
	Cv5TFXGCMWlmYPsgA0Rg3TAZhYhr9
X-Received: by 2002:adf:e242:0:b0:2c5:4db8:3dde with SMTP id bl2-20020adfe242000000b002c54db83ddemr10156088wrb.70.1678237579059;
        Tue, 07 Mar 2023 17:06:19 -0800 (PST)
X-Google-Smtp-Source: AK7set9aaqH/TcooYJSjXIYn0J4gmlCjhzm5NBHt+JeMjIzwHk2iG4QnNQtikyW+hzxEcDyP8QY9MQ==
X-Received: by 2002:adf:e242:0:b0:2c5:4db8:3dde with SMTP id bl2-20020adfe242000000b002c54db83ddemr10156071wrb.70.1678237578758;
        Tue, 07 Mar 2023 17:06:18 -0800 (PST)
Date: Tue, 7 Mar 2023 20:06:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
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
Message-ID: <20230307200307-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302201912.GC2554028@fedora>
 <20230302185803-mutt-send-email-mst@kernel.org>
 <20230303131703.GB2866370@fedora>
 <20230303081900-mutt-send-email-mst@kernel.org>
 <4f869944-4ccd-c51e-0f30-dc3ba15ffd52@nvidia.com>
 <20230307192752-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811A704524CE59CCDB2B1EDCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811A704524CE59CCDB2B1EDCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

On Wed, Mar 08, 2023 at 01:01:27AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, March 7, 2023 7:34 PM
> > COMMAND_SPECIFIC_ERR is just way too much detail - commands generally
> > just should not fail it's a quality of implementation issue.
> 
> I disagree partially.
> 
> 1. Hw device != sw_hypervisor device.
> Device may fail or error out that may need want sw driver to retry.
> Like Stefan's example, it may need to return timeout/retry intermittently.
> Doesnt means the device is broken at that point.
> 
> 2. A device implementation may not have imposed a certain locking scheme to synchronize VF enablement with VF provisioning.
> ENODEV can reflect two commands not synchronized.
> 
> So Boolean 0 = success, 22 = error is not the right way to craft the spec.
> Many times, those sub-error codes are good indications of what may have gone wrong in the field.
> Useful for the quality issue you pointed out to debug.

Maybe, but I think we can just leave this stuff for later. Too much
hand-waving, when we add commands that actually need this kind of
ability that is when we will add the relevant error codes.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

