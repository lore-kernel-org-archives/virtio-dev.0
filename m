Return-Path: <virtio-dev-return-11416-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4191C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 08:35:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7AF3E33096
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 08:35:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 022859867A3
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 08:35:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8B19198679A; Fri,  3 Mar 2023 08:35:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BE3F986797
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 08:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qry6ZT9YOWGETPEhuI5AXw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677832459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0HSAE3AQqMmDdxRGNrpzTJNdr1jBczaDw9KJfCQEUk=;
        b=3A9l2d2T4gkzakkjf/TVuhL+yV7q3g9tGooU1GGUc3Z0qxh0UOwV3gaZp1K+E8/Mrh
         OpzDyD0QFRuSc8ce+hLyPDqwwabaewxL1iMe/y/tlFf+B+L8d8xYIFYp92f7XT5CnvXm
         Tpb3j80qmjtMGxiYPInFcO3l+Ud9fYrSdtw72CezZNBcpBBdkO1wKYHf24EvJoK2zmKz
         LMKXXOfkG1KFRMH0akF06XDAmRihkdOtMwbaC4hOOsQwqRLmhVkaiagqDk/XEhWTdRK+
         kXfZdftd14s/dt3GAgPo0DHjcKX1LDnsQu6BMnA+5GcUuclRWmpIEO4Rqofrt1uv14Ie
         XweQ==
X-Gm-Message-State: AO0yUKXrFuuH/msCuW/yIMU0agQBtzB30sZIaPBYcw41PrCKJyJMm1Oi
	mOPX7qTdL2AMWFyhVdFbpLtLtA4IROMswi8WRySjycY9/8bgjftk7cALlDsHfy2x36FxIWKn/Oc
	hHFbWidPYMgB7O0Nv/OcyWqVto3Rs
X-Received: by 2002:a05:600c:3b07:b0:3ea:ea3e:2d36 with SMTP id m7-20020a05600c3b0700b003eaea3e2d36mr966589wms.24.1677832459003;
        Fri, 03 Mar 2023 00:34:19 -0800 (PST)
X-Google-Smtp-Source: AK7set8s0wiZzPzglduqNVpsc2raaLq+m6KGF89Kx4HEeZ8eEf05vaf1ZKeSLW5KE3LAD/oNxqoxmw==
X-Received: by 2002:a05:600c:3b07:b0:3ea:ea3e:2d36 with SMTP id m7-20020a05600c3b0700b003eaea3e2d36mr966570wms.24.1677832458733;
        Fri, 03 Mar 2023 00:34:18 -0800 (PST)
Date: Fri, 3 Mar 2023 03:34:14 -0500
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
Message-ID: <20230303032434-mutt-send-email-mst@kernel.org>
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
> Did you miss reviewed-by from [1] or this is an old series reposted?
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00242.html

As a general rule, we don't strictly need to track reviewed by since
there's a ballot (and presumably people review before voting).

People also tack on Signed-off-by: (and I do it too) but
as long as we don't document what it means it's kind of vague,
and the process of subscribing to the mailing list is
a kind of replacement.

If you think everyone needs to follow practices like netdev does,
we really need something written up, and agree on it.

E.g.  I work on the linux kernel too, so I can copy practices from
there, but even linux isn't uniform.

And I wonder whether it's worth it - it definitely makes
contributing to Linux harder, and even within Linux it pushes
contributors away. At least for Linux tracking history
in a precise way is extremely important since it's helpful
with stability. Spec is very different.

Until we have a good contribution documentation I think we should not
ask people to follow a pseudo linux work flow with requests like "please
split this patchset up" or "track changes across patch versions"
simply because there's no good docs to teach people what exactly is
the best practice.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

