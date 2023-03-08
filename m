Return-Path: <virtio-dev-return-11508-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD05C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:55:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7521A2AC50
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:55:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D410986701
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 11:55:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5DA6E9866F2; Wed,  8 Mar 2023 11:55:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43EB59866EE
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 11:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: K28rg5dfPLG-02CxU92Pdw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4hZo98+UXQ+0kYz5lbRPjykRGCYM7w+Ao/3kZ+T1SA=;
        b=f1krm7zhWXto/zYn5ckWj9w8IbJVUb6Ql7u0P+0rYUckoKQv9zRvRuQBjzqhkz8gsv
         /PnuUMKlEWXjtQKGBaLJgRfLOOJlQGw88S6C/b4eZnQcOXoxTQzSmWZ12eyMSuQeRDfT
         kWGjAea6COdCZ6X5g4gI6FJN53VhjBPJD8GkGi/Ny+S1YqRL40iCvUMV7DBHg2L2WuFs
         OYjM5pn4qsrvIMUBUcIh2tEIN1gQhzms4IBm32BKIe3ZuCyLExCsrQ6Jodew34oayxpk
         McaXAp1tkb/ltWQq8u6OBIyITRU/zT0EdaPxnRw78tIDDkp7boMZDdQQ6yhut2pn51Ki
         1kQg==
X-Gm-Message-State: AO0yUKX+oUQRmYEXXb8mBdksTC4xd1Wpu2OXr2yQ0EKaLTWM/Ggqudop
	wys18NI4J+LzebDutsv2AqG06AUxD6Lhryp4pAz5LDcsd0po4dog2qL542Q41hM2X1GKws5gxRp
	IPbx999MOzukTUUj/pithdNpIRfYw
X-Received: by 2002:aa7:db53:0:b0:4ab:15d9:2dae with SMTP id n19-20020aa7db53000000b004ab15d92daemr17162598edt.14.1678276497713;
        Wed, 08 Mar 2023 03:54:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8oN2Nd8KCT+zigHcOBfKG3QAtMWTDA6m4JMvrqlpwVuX8hU7wKPNn2ynfvcHUGFs3Vn+JNaQ==
X-Received: by 2002:aa7:db53:0:b0:4ab:15d9:2dae with SMTP id n19-20020aa7db53000000b004ab15d92daemr17162581edt.14.1678276497453;
        Wed, 08 Mar 2023 03:54:57 -0800 (PST)
Date: Wed, 8 Mar 2023 06:54:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308065109-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
 <ZAXbBgN2jw8RhE/3@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAXbBgN2jw8RhE/3@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v10 08/10] admin: command list discovery

On Mon, Mar 06, 2023 at 01:22:30PM +0100, Jiri Pirko wrote:
> Thu, Mar 02, 2023 at 02:05:22PM CET, mst@redhat.com wrote:
> >Add commands to find out which commands does each group support,
> >as well as enable their use by driver.
> >This will be especially useful once we have multiple group types.
> >
> >An alternative is per-type VQs. This is possible but will
> >require more per-transport work. Discovery through the vq
> >helps keep things contained.
> >
> >Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> [...]
> 
> 
> >+
> >+The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
> >+query the list of commands valid for this group and before sending
> >+any commands for any member of a group.
> >+
> >+The driver then enables use of some of the opcodes by sending to
> >+the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
> >+of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
> >+both understood and used by the driver.
> 
> To my untrained ear, this sounds somewhat similar to the feature
> negotiantion mechanism. Why the fact that device/driver supports some
> command can't be covered by just another feature? Looks like unnecassary
> complexicity to negotiate supported commands like this.

Absolutely, it is similar. The issue is that a single device can
be an owner for multiple group types.
For example, I think an SRIOV PF itself can have subfunctions with SIOV
as well as virtual functions with SRIOV.
And the set of supported commands might differ.

We thus need a command that is kind of like features but per group type.

As a small bonus as we are building this from scratch, I added
something which was requested for a long time from features
which is blocking access to commands not allowed by features.
With standard virtio features we trust the driver not to send
commands before enabling a feature and this was considered
a maintainance/security problem.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

