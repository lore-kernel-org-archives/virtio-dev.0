Return-Path: <virtio-dev-return-11879-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167E6C76196
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 11:39:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3E7282AED6
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 11:39:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 233E498657D
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 11:39:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1098C986565; Fri, 31 Mar 2023 11:39:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3F6298656B
	for <virtio-dev@lists.oasis-open.org>; Fri, 31 Mar 2023 11:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oo0u8MtqPuqyDAqBCe-Ltw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680262756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDr21lI5I6vtilTlDUkj5SBTYSBavqztROjvjsUGXxg=;
        b=TCFOph79GyDYGtPZH8vtjFtevoUVuzToax3DjGuvRQIUtKfG/YzS5wz/zNtazJVvbp
         +0MBXrslmBDNf8oAuOWLDMvC2XDb+Oa7FqtZ/VZH7BFEtTk6+QLiLaQ2nM6/w2FfULxl
         uQZMZgGmLEuFORaI259bP4YoZHtURDvjMOL20ja5wrs4tBtlgUmmD/MPSlLvYIYN00Y/
         Y99JvXAfUdbuwdkAD9BvceFx2LN5ohQGa/B4rOqzJJbb+4tqYNBmioDIDKsXNf9jiG4g
         SeIpnzM1zZf8Tt3pw4CrMRsYcsRSBbnu2bSqgFCECRgfaCQuYRKn9Sdi7uX7schaQQME
         dXBw==
X-Gm-Message-State: AO0yUKXcV/a0r+5Cf/dhFi3qPEv7OKhQJCWYbGlOJeZsNK/BCZOrcpQf
	6hhFDLtJdvtTUZ1Z+Uo9YlKXhetDwqqSHekixq1xTZOwtcb+vExtNnP0U9t29dLuPbniTlOZFDQ
	QKFZZytBKYJ0fzePPtIRAeKnBiAxB
X-Received: by 2002:a7b:c44f:0:b0:3ed:d3a7:7077 with SMTP id l15-20020a7bc44f000000b003edd3a77077mr19096371wmi.40.1680262756460;
        Fri, 31 Mar 2023 04:39:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set+fNeL4t2knP3wvcbv7GPv/3Hk3Gg86h+VknPLKLvTn5o8heFMeTFWHerPEufe2Zw34JVdMEQ==
X-Received: by 2002:a7b:c44f:0:b0:3ed:d3a7:7077 with SMTP id l15-20020a7bc44f000000b003edd3a77077mr19096358wmi.40.1680262756090;
        Fri, 31 Mar 2023 04:39:16 -0700 (PDT)
Date: Fri, 31 Mar 2023 07:39:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230331073719-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
 <20230302210929.GH2554028@fedora>
MIME-Version: 1.0
In-Reply-To: <20230302210929.GH2554028@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 08/10] admin: command list discovery

On Thu, Mar 02, 2023 at 04:09:29PM -0500, Stefan Hajnoczi wrote:
> Is the purpose of VIRTIO_ADMIN_CMD_LIST_USE so that new commands can be
> added that are mandatory for device operation. Failure to include them
> in the VIRTIO_ADMIN_CMD_LIST_USE command terminates device
> initialization with an error?

Or, switches the device to some legacy mode.

> Are commands evolved by defining flag/version bits in the command
> specific data struct? For example, if a new field needs to be added to a
> command and a 0 value carries a meaning (so it cannot simply be added to
> the end of the existing struct with backwards compatibility).
> 

commands expect to be evolved by extending the command specific
structure at the tail. this is why I spent so much time
on that in the text. if that does not work a new command will
work.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

