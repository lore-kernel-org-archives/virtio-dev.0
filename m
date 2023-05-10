Return-Path: <virtio-dev-return-12631-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD28DC77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:12:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C27CDFD566
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:12:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD06E9866CD
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:12:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B16149865B0; Wed, 10 May 2023 16:12:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9919B9866DB
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 May 2023 16:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: XWgZ3bFAOwuUDIw_X0XUog-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735125; x=1686327125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV1seWEpB1z4KZ5f5HR0o4/9t2SuHvHj5Ul3uAnb3PU=;
        b=eeCF6t5sCFsi06c9xE/d28okXcd3Q1ULQllktPLSvoutb7BWZfWyLZLYqLTZVT+V4Q
         5xrIjfGtE4GvFWbzT8vtZcW2u2zgcyU4UqsVyUfyhQL1Tlngy6jCqR5+xXjxhNGhLtxD
         NbqyZfSxViqbOUlBHlks1C0TNHPFoLBe2iow5aCUIpn4D8GGAxMZ6jfXf7SlWEsaZnJ+
         vKzc5x5FoKSSaz4rn4zj3gf1E50WEDlXIKof/LhVCAFwt/x6wvgcamRGe4s4BR8yUCqu
         jM+Yfco9jRTrN5JPT1JX2/FQMwsujxJoT2JcLeHveezSoYjFj/0h/zwQYzTwlSIufD6i
         2Hxg==
X-Gm-Message-State: AC+VfDwRtqU/Sd7LE3/8jr/3/OZ528/ljb7YZFZj+ZJNx7ogESvbYGx/
	C81xXW0DJ0IdRvXkqIrC9MwSH4bUYK17ks8GegZvCXflgR2R1DL3DcWx473O0kuAT8X+SSuLrQk
	AnS1g9GGfrD61+GjOmTnGcxQxTLFs
X-Received: by 2002:a7b:c7c3:0:b0:3f3:195b:d18c with SMTP id z3-20020a7bc7c3000000b003f3195bd18cmr11439678wmk.30.1683735124827;
        Wed, 10 May 2023 09:12:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5N3kvRrggkQA5FG2DRAMhm887wXf34WjD8cLyMfOKtqJmebwB/udG+oDLX+w3xT+PNoyK/Ew==
X-Received: by 2002:a7b:c7c3:0:b0:3f3:195b:d18c with SMTP id z3-20020a7bc7c3000000b003f3195bd18cmr11439653wmk.30.1683735124507;
        Wed, 10 May 2023 09:12:04 -0700 (PDT)
Date: Wed, 10 May 2023 12:11:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jiri Pirko <jiri@nvidia.com>,
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
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230510121110-mutt-send-email-mst@kernel.org>
References: <cover.1683301091.git.mst@redhat.com>
 <ZFuqesg6YUSJi4dd@nanopsycho>
 <PH0PR12MB54814BF87CB79304EAAADC79DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54814BF87CB79304EAAADC79DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v13 00/10] Introduce device group and device management

On Wed, May 10, 2023 at 02:33:52PM +0000, Parav Pandit wrote:
> 
> > From: Jiri Pirko <jiri@nvidia.com>
> > Sent: Wednesday, May 10, 2023 10:30 AM
> 
> > 
> > Michael, not sure if it is problem of this patchset or on my side but makepdf
> > fails to build this. With master branch, works fine.
> 
> This patch fixes it.
> https://lore.kernel.org/virtio-comment/20230505163712.589460-1-parav@nvidia.com/
> 
> You can use b4 now to get this patch.

Thanks a lot, I will fold your patchset in when applying.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

