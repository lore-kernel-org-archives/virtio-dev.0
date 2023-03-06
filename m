Return-Path: <virtio-dev-return-11456-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E585C64EC4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 18:46:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 123C044347
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 18:46:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 03C569866CC
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 18:46:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E2FFA9866BD; Mon,  6 Mar 2023 18:46:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0A899866C7
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 18:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tx5pbIAKOjiH-gnuD8mTdA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678128375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Asbr/RlbGGJgG1C7LoI9h8RVUFLRJXUIQ3IQ+QJ7zwU=;
        b=unn6gdnInu2kphst9L9yXZ9uHeQPdqe/4xdfMhgo19oTZVR9ig18jxrGnfum32qO3M
         XwoHStOoaOcwAHhkSu17enYq2rZ2MxISysSIT2N1f61KUblt8ykLiMfAksLzbIChStRr
         jYSMkr9hRxY+Q2QQHp9wr9zNN9iYYpEkZks5S9J8mMYbqE0D53FKGpTlnn3/7faYc7sA
         0MwJ555Godi8Jaw9x5uIIbvyXbz1YhO7GYp8M4BGjwMiNddYnn+3oOAql2op9yxfcstI
         3sV6hQAH36/fooHLa9+Dnl1yAcLoAdWjkeqMXjPzAhVXx48rM10G5dxW7N5AWNPu0Dc8
         +rXg==
X-Gm-Message-State: AO0yUKUX1HdDRNa7p/bPMRsR7SHl0Mu/ZcW/4dsReTU2BvnLvmXCPIWq
	CGbrJRVtI4dT1sbiycfaWnM9KceewI/QxViRxY0KPaT/4tkdmrA56inmZL7NCnbUgqIp7VzBIZ/
	H/MfTKETcsGyrOrF+jFTI+psEakZP
X-Received: by 2002:a05:600c:310a:b0:3dc:555c:dd30 with SMTP id g10-20020a05600c310a00b003dc555cdd30mr10379021wmo.27.1678128375161;
        Mon, 06 Mar 2023 10:46:15 -0800 (PST)
X-Google-Smtp-Source: AK7set95ezq23oCkCs1iLRCrh45pPQlaw9vKEw6wp3Woz/n2BKv5mF9OPSTFyBLp+jXRHP+8//QpBw==
X-Received: by 2002:a05:600c:310a:b0:3dc:555c:dd30 with SMTP id g10-20020a05600c310a00b003dc555cdd30mr10379010wmo.27.1678128374862;
        Mon, 06 Mar 2023 10:46:14 -0800 (PST)
Date: Mon, 6 Mar 2023 13:46:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
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
Message-ID: <20230306134451-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <dd9c34ed74ee296228562f6946d4ca3f2fbee1e1.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481595368C8F0C0E16B681BDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230303032434-mutt-send-email-mst@kernel.org>
 <ZAXB44F3MS9CxIiK@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAXB44F3MS9CxIiK@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 06/10] mmio: document ADMIN_VQ as
 reserved

On Mon, Mar 06, 2023 at 11:35:15AM +0100, Jiri Pirko wrote:
> Well, lots of these things (if not majority) are customary, not
> really written up anywhere in Linux kernel netdev world. It's most of
> the time just a matter of convenience I would say. For example
> splitted-up patch changelog. I do it, but most of the people don't (even
> maintainers). From time to time during review, I request it as I don't
> want to be lost in the changes. It is nice if the submitter tries to
> make reviewer's life a bit easier :)

True. With all this lore let's just agree netdev is not the easiest
project to get started with, right?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

