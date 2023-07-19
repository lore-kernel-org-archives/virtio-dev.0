Return-Path: <virtio-dev-return-13384-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AB5C001B0
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Jul 2023 14:02:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AFE067534A
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Jul 2023 14:02:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3A3E9867FA
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Jul 2023 14:02:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 980419866A2; Wed, 19 Jul 2023 14:02:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 838109866AB
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jul 2023 14:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 9ER8wYgNMXKk5ZIDeE1wTg-1
Date: Wed, 19 Jul 2023 16:02:35 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, 
	Robert Beckett <bob.beckett@collabora.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>, Alex Deucher <Alexander.Deucher@amd.com>, 
	Christian Koenig <Christian.Koenig@amd.com>, Stewart Hildebrand <Stewart.Hildebrand@amd.com>, 
	Xenia Ragiadakou <burzalodowa@gmail.com>, Honglei Huang <Honglei1.Huang@amd.com>, 
	Julia Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>
Message-ID: <ssg43kipfjmaqhegnlnd4gog3kxz2vhfvodbxxruez2zodwmzx@bqpb67ud7ssg>
References: <20230712093629.1410765-1-Jiqian.Chen@amd.com>
 <20230712093629.1410765-2-Jiqian.Chen@amd.com>
MIME-Version: 1.0
In-Reply-To: <20230712093629.1410765-2-Jiqian.Chen@amd.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [VIRTIO GPU PATCH v2 1/1] virtio-gpu: Add new feature flag
 VIRTIO_GPU_F_FREEZING

> +\begin{lstlisting}
> +struct virtio_gpu_status_freezing {
> +  struct virtio_gpu_ctrl_hdr hdr;
> +  __u32 freezing;
> +};
> +\end{lstlisting}

> +This is added for S3 function in guest with virtio-gpu. When guest does
> +S3, let it notify QEMU if virtio-gpu is in freezing status or not in
> +\field{freezing}. Zero means it is not in freezing status, none-zero
> +is the opposite. When virtio-gpu is in freezing status, QEMU will not
> +destroy resources which are created by using commands
> +VIRTIO_GPU_CMD_RESOURCE_CREATE_*, so that guest can use those resources
> +to resume display.

Good, thanks for the update.

> +Note: this change is not enough to solve the problems of S4 function.
> +QEMU may lose resources after hibernation. It needs more research and
> +development.

So, eventually we will see changes to this in the future.  I'd suggest
to use an enum for freezing, so this can be extended with more modes in
the future, i.e. something along the lines of:

enum virtio_gpu_freeze_mode {
    VIRTIO_GPU_FREEZE_MODE_UNFREEZE  = 0,
    VIRTIO_GPU_FREEZE_MODE_FREEZE_S3 = 3,
};

Maybe also add a "_S3" postfix to the feature flag name.  In case we add
S4 support at some point in the future we will need another feature flag
for that.

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

