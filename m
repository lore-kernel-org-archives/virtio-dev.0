Return-Path: <virtio-dev-return-13310-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95625C0015E
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 10:27:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BC45D2B02B
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 10:27:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95BB9986808
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 10:27:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7FF589867EB; Fri,  7 Jul 2023 10:27:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AA7D9867F9
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 10:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ruaeWSvLNpOAhh9OeqO1hQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688725669; x=1691317669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54p/PmWGHWokTtblzt6CfBjeUnBZM3+DK3iF3H3NqGI=;
        b=cmKNUnzjEoSOhg3LXjd9EtdCTuIlXo96Oa1ZpM1ZAlMRAKjXil+AUTVOBgpps9pzxc
         XdzoYNjNusFRGO2JFfNiZOsXbGwwOWy/zdpBQga4uXWn+nGs5wShDGFb+PmRn6VBesI8
         r/5w+eejiZx86vrN37ZaYU7cJc6vt48ll8wbafGDaFK5OaFNOSmykDEcwdrjurtE+gti
         FgYr5YTufmPyEkdtUZ14qXBLp+31JWAOVmtlMTcBX++ZoGLCDIt514b8YG4d4nlxUjh4
         a64ISk4crRro47Ve7XIcrrtcL3BI8DFwzMIZOW65ZiGwzSnBVld3PR9O/8Pskom0RMpV
         Loog==
X-Gm-Message-State: ABy/qLYOizstkYTb7bRnMH8wLJ+wuciC4QniNWSn3xXFHHkEFWEB3/Gu
	4kZKGZF/Ws2LVMneBzT6/ZsCCaegsauCghtyJj2EaLiRWOmAsxZ1DKVjzhzmIpF1qqvqHwBmZSW
	Tj3KBdW9NldTtMOq4ygg1Kvs226Lc
X-Received: by 2002:ac8:5895:0:b0:3f4:e1b4:e45 with SMTP id t21-20020ac85895000000b003f4e1b40e45mr4850612qta.60.1688725669600;
        Fri, 07 Jul 2023 03:27:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6b+U3LMgCwW3PWA8NX5vI6q/KHQchzLhLkXTI9jlf/a9KUVhIkJHlnxLCF+fl4NpyVvg5Iw==
X-Received: by 2002:ac8:5895:0:b0:3f4:e1b4:e45 with SMTP id t21-20020ac85895000000b003f4e1b40e45mr4850601qta.60.1688725669338;
        Fri, 07 Jul 2023 03:27:49 -0700 (PDT)
Date: Fri, 7 Jul 2023 12:27:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, 
	mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, 
	viresh.kumar@linaro.org, takahiro.akashi@linaro.org, erik.schilling@linaro.org, 
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <qmwvywoy7lfkgr7kcc6cxghulgd5g2gvnv76mvkuxbqclbwmti@4qyiktfiu2ej>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
 <87o7krg0sn.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87o7krg0sn.fsf@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE
 protocol feature for vhost-user

On Tue, Jul 04, 2023 at 04:02:42PM +0100, Alex Bennée wrote:
>
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
>>>Currently QEMU has to know some details about the back-end to be able
>>>to setup the guest. While various parts of the setup can be delegated
>>>to the backend (for example config handling) this is a very piecemeal
>>>approach.
>>>
>>>This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
>>>which the back-end can advertise which allows a probe message to be
>>>sent to get all the details QEMU needs to know in one message.
>>>
>>>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>
>>>---
>>>Initial RFC for discussion. I intend to prototype this work with QEMU
>>>and one of the rust-vmm vhost-user daemons.
>>
>> Thanks for starting this discussion!
>>
>> I'm comparing with vhost-vdpa IOCTLs, so my questions may be
>> superficial, but they help me understand the differences.
>
>I did have a quick read-through to get a handle on vhost-vdpa but the
>docs are fairly empty. However I see there is more detail in the linux
>commit so after looking at that I do wonder:
>
> * The kernel commit defines a subset of VIRTIO_F feature flags. Should
>   we do the same for this interface?

Sorry, I didn't get this.

Do you mean that the kernel is filtering some features?
Or are you talking about backend features?

>
> * The VDPA GET/SET STATUS and GET/SET CONFIG ioctls are already covered
>   by the equivalent VHOST_USER messages?

Yep, I think so.

>
>>>---
>>> docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>>> hw/virtio/vhost-user.c      |  8 ++++++++
>>> 2 files changed, 45 insertions(+)
>>>
>>>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>>>index 5a070adbc1..85b1b1583a 100644
>>>--- a/docs/interop/vhost-user.rst
>>>+++ b/docs/interop/vhost-user.rst
>>>@@ -275,6 +275,21 @@ Inflight description
>>>
>>> :queue size: a 16-bit size of virtqueues
>>>
>>>+Backend specifications
>>>+^^^^^^^^^^^^^^^^^^^^^^
>>>+
>>>++-----------+-------------+------------+------------+
>>>+| device id | config size |   min_vqs  |   max_vqs  |
>>>++-----------+-------------+------------+------------+
>>>+
>>>+:device id: a 32-bit value holding the VirtIO device ID
>>>+
>>>+:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
>>>+
>>>+:min_vqs: a 32-bit value holding the minimum number of vqs supported
>>
>> Why do we need the minimum?
>
>We need to know the minimum number because some devices have fixed VQs
>that must be present.

But does QEMU need to know this?

Or is it okay that the driver will then fail in the guest if there
are not the right number of queues?

>
>>
>>>+
>>>+:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
>>
>> Is this overlap with VHOST_USER_GET_QUEUE_NUM?
>
>Yes it does and I considered implementing a bunch of messages to fill in
>around what we already have. However that seemed like it would add a
>bunch of complexity to the interface when we could get all the initial
>data in one go.

Yes I understand, though if we need to add new things to return in the
future how do we do it? Do we need to provide features for this
structure?

>
>>
>>>+
>>> C structure
>>> -----------
>>>
>>>@@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>>>           VhostUserConfig config;
>>>           VhostUserVringArea area;
>>>           VhostUserInflight inflight;
>>>+          VhostUserBackendSpecs specs;
>>>       };
>>>   } QEMU_PACKED VhostUserMsg;
>>>
>>>@@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
>>> * ``VHOST_USER_GET_VRING_BASE``
>>> * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>>> * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
>>>+* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
>>>
>>> .. seealso::
>>>
>>>@@ -885,6 +902,13 @@ Protocol features
>>>   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>>>   #define VHOST_USER_PROTOCOL_F_STATUS               16
>>>   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>>>+  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
>>>+
>>>+Some features are only valid in the presence of other supporting
>>>+features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
>>>+backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
>>>+``VHOST_USER_PROTOCOL_F_STATUS``.
>>>+
>>
>> What about adding a new section where we will describe what we mean
>> with "standalone" devices?
>>
>> For example that the entire virtio device is emulated in the backend,
>> etc.
>>
>> By the way, I was thinking more about F_FULL_DEVICE, but I'm not good
>> with names, so I'll just throw out an idea :-)
>
>Naming things is hard ;-)

I know :-)

>
>I could add a new section although AIUI there is nothing really in
>existing daemons which is split between the front-end and back-end. The
>stubs are basically boilerplate and ensure DT/PCIe hubs make the device
>appear so once things are discovered QEMU never really gets involved
>aside from being a dumb relay.

For the backend I don't think there is much to say, but for the frontend
it changes a lot in my opinion if this new feature is supported, since
we basically offlaod the whole virtio device to the external process.

Thanks,
Stefano


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

