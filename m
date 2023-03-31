Return-Path: <virtio-dev-return-11880-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37F9C76196
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 11:44:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 29E8C3711F
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 11:44:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17D6F98657E
	for <virtio-dev@archiver.kernel.org>; Fri, 31 Mar 2023 11:44:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0A3BD986565; Fri, 31 Mar 2023 11:44:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF1FB986566
	for <virtio-dev@lists.oasis-open.org>; Fri, 31 Mar 2023 11:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1MbfiWeANwqpOVeQBCQrDw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680263038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiI5Fx0gOiS0j9vjT5qKlcwbTqaHq1awFnXZb/uWE0g=;
        b=yL6S3Z5J7fMFvxRYMOIi3s6AF/sikpoeQjssr76rew3/BavfvHkY1wG9Y6sZ8Mxpq3
         sfLsncmoI0XYSfmDT9mxvIv3qCkOlCSW8xDdGW/BTJZ7b+yijCTGeZRQH4CQa9EKM+k0
         9JYV1FzXJce5i+W67TPGrKydDafhZhBR69TzgCsWnoK8yAZ/fX5ruE32j7XZiYptxdtr
         vGXi0oWkjpCtKAJKvljrK7UzwiaxnaMG9mPgPDR1b8vBLixur90zTxDAB5E8Z5M4cOtz
         DTbBPvcYGkMWzIxf4NZwtiQf4kk3jn59djmvZlGnR24H7Uukke+Do9N9EqsAv82Ubqba
         iYbg==
X-Gm-Message-State: AAQBX9chhsEbVqnMcHHhyiHTK7SJdXGAWLwzUlrfAXzNg5bbdQL5Gzkd
	JmNUs0LfeoYsMElaGq78RipBDACQ15KXjxHPeDBU7G2TIydJQlrOOrtG9F7sKckb/3wLmHFpMwu
	7Xly2cpBnkjkhUeIgk4dwxOR8dXwK
X-Received: by 2002:adf:e8c3:0:b0:2cd:e089:398d with SMTP id k3-20020adfe8c3000000b002cde089398dmr6262898wrn.5.1680263038577;
        Fri, 31 Mar 2023 04:43:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yw9zgdqt988oQFCMGc0tLLo4KGa/GG2MVWaAzjzEKK7XmMFr8DeYqVQScBDdjpbYGIsu3xgA==
X-Received: by 2002:adf:e8c3:0:b0:2cd:e089:398d with SMTP id k3-20020adfe8c3000000b002cde089398dmr6262878wrn.5.1680263038242;
        Fri, 31 Mar 2023 04:43:58 -0700 (PDT)
Date: Fri, 31 Mar 2023 07:43:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230331074247-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
 <ZAXbBgN2jw8RhE/3@nanopsycho>
 <20230308065109-mutt-send-email-mst@kernel.org>
 <ZAiCgRLWcU1JFNWt@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAiCgRLWcU1JFNWt@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] [PATCH v10 08/10] admin:
 command list discovery

On Wed, Mar 08, 2023 at 01:41:37PM +0100, Jiri Pirko wrote:
> Wed, Mar 08, 2023 at 12:54:52PM CET, mst@redhat.com wrote:
> >On Mon, Mar 06, 2023 at 01:22:30PM +0100, Jiri Pirko wrote:
> >> Thu, Mar 02, 2023 at 02:05:22PM CET, mst@redhat.com wrote:
> >> >Add commands to find out which commands does each group support,
> >> >as well as enable their use by driver.
> >> >This will be especially useful once we have multiple group types.
> >> >
> >> >An alternative is per-type VQs. This is possible but will
> >> >require more per-transport work. Discovery through the vq
> >> >helps keep things contained.
> >> >
> >> >Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> >> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> 
> >> [...]
> >> 
> >> 
> >> >+
> >> >+The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
> >> >+query the list of commands valid for this group and before sending
> >> >+any commands for any member of a group.
> >> >+
> >> >+The driver then enables use of some of the opcodes by sending to
> >> >+the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
> >> >+of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
> >> >+both understood and used by the driver.
> >> 
> >> To my untrained ear, this sounds somewhat similar to the feature
> >> negotiantion mechanism. Why the fact that device/driver supports some
> >> command can't be covered by just another feature? Looks like unnecassary
> >> complexicity to negotiate supported commands like this.
> >
> >Absolutely, it is similar. The issue is that a single device can
> >be an owner for multiple group types.
> >For example, I think an SRIOV PF itself can have subfunctions with SIOV
> >as well as virtual functions with SRIOV.
> >And the set of supported commands might differ.
> >
> >We thus need a command that is kind of like features but per group type.
> 
> I see. But that does not mean it can't be done using existing features:
> 
> _F_SRIOV_CMD1
> _F_SRIOV_CMD2
> ..
> _F_SIOV_CMD1
> _F_SIOV_CMD2
> ...

True. But annoying if each command has to be duplicated.

> >
> >As a small bonus as we are building this from scratch, I added
> >something which was requested for a long time from features
> >which is blocking access to commands not allowed by features.
> >With standard virtio features we trust the driver not to send
> >commands before enabling a feature and this was considered
> >a maintainance/security problem.
> 
> I understand. Is it unfixable for features not to break buggy drivers?
> 

I think it is, feature negotiation is hard to evolve since our
compat strategy is built around feature negotiation.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

