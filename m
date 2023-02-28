Return-Path: <virtio-dev-return-11330-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F3DC64ED6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 07:50:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8EB702A884
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 07:50:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 224B59867BC
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 07:50:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 86ED9986602; Tue, 28 Feb 2023 07:50:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D01B2986601
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Feb 2023 07:49:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ZnVgzjkXMTCjojFJOMMRSw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677570585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3zwKTGUUlPNs9M/Q7UUksEwevprK2Xl1IMl5TSWx2k=;
        b=BEq/q0aBFFc2RNWuyeciWqThiRKXHjYLlKR2kssKuhALkwDgNk88vSXkW6r4x+bYWE
         zVHZdH9q1ZT/qdCUbUnsUTXlD8+5xrmq4PBSbzuAtkBaQw2h6fb2KitBjLJLY6iTkTxE
         k4HgbHJAh1oc643CgrVOIycmTMn/dUDC17e+Dd/OJ9mfigcqjdOJ9WJ/jT0q2MRpNGXl
         Hcw+X4asIFqnqlHNOQnFxHbtx9/vf03Bw4LKo0MZmY5E5ByxjUi31ev9seRrrDHn3WB7
         FzsLvgur6S+BST26WmZvxwT414FftX40y1IfHlXb7TYvR0igsAKcDXihYTwF/ey6nI3g
         Thkw==
X-Gm-Message-State: AO0yUKXYAecTcmrKa380jwa3MQRf6JBc7O+di5t2k5tMUv+zacvvCvG7
	1xrDNQE5GDIitHzeMVrw0MXVxyxdWWrmkL9Ug1h6PK/lI0EevA7bVLDyc8wfTE2wflWgTeKCrOh
	N27pOjtUOl5GojugszyV3kX8bsvQO
X-Received: by 2002:aa7:c481:0:b0:4ad:7493:7a98 with SMTP id m1-20020aa7c481000000b004ad74937a98mr2324636edq.3.1677570585746;
        Mon, 27 Feb 2023 23:49:45 -0800 (PST)
X-Google-Smtp-Source: AK7set9NrWy4X4tM28J89jUtpPY9gaCXFRYG5TKEwZVKD4PKlB069Q5gj9w3PBfEqT2qDcASgMMVcw==
X-Received: by 2002:aa7:c481:0:b0:4ad:7493:7a98 with SMTP id m1-20020aa7c481000000b004ad74937a98mr2324603edq.3.1677570584977;
        Mon, 27 Feb 2023 23:49:44 -0800 (PST)
Date: Tue, 28 Feb 2023 02:49:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230228024829-mutt-send-email-mst@kernel.org>
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
 <CAJs=3_CGcYc1dPv2x+U-vy7smGBQ3cGWNzi_D-KzpMT2RdVzrg@mail.gmail.com>
 <1ba1c6ed-6a3f-21e6-dbb2-0f1a1ed9ca62@linux.alibaba.com>
 <CAJs=3_DND7WdoXc19XzOKDDKYNXFKdKRMr6j93p9z7=5EyGHGQ@mail.gmail.com>
 <20230227151420-mutt-send-email-mst@kernel.org>
 <46d5248b-1632-22b1-03b0-7ca64d536f04@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <46d5248b-1632-22b1-03b0-7ca64d536f04@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support the virtqueue
 coalescing moderation
Message-ID: <20230228074941.8F7h5TdMMMiEnEbVoWb6q0vm4a2TLbf7xw7o5XG7Wio@z>

On Tue, Feb 28, 2023 at 10:41:18AM +0800, Heng Qi wrote:
> > The problem is the global qualifier. And it's not even global -
> > there are two sets for rx and for tx and does not apply to cvq at all.
> > How about "RX/TX coalescing parameters"?
> 
> As Parav suggested, we probably don't need to mention "global
> values/coalescing parameters" since this values/parameters are the ones set
> by CTRL_NOTF_COAL_RX/TX_SET.
> 
> Just like this:
> "
> After disabling and re-enabling a virtuqueue, the device MUST revert to
> coalescing parameters to the one configured using VIRTIO_NET_CTRL_NOTF_COAL.
> "
> 
> Thanks.

VIRTIO_NET_CTRL_NOTF_COAL is not a thing. Let's wait for Alvaro's new
patch to be merged though, see what teminology he comes up with and
reuse.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

