Return-Path: <virtio-dev-return-13267-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A01EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:48:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C38383F8E6
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:48:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC143986809
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:48:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AF541986728; Thu,  6 Jul 2023 16:48:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DAC9986729
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 16:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tSrbmdeKMx2_hDxJldL8aQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662107; x=1691254107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B20pzgSCy9bRRmFfmCFNU1EXVhpPGrkXs8P+PNa0uiU=;
        b=AisG+RRWirTn18LpLF+6LOGyjVvloJEfB1LGEzcfz5FpomWWmuWh7qxZJiMd+Pm1Fw
         T8TMYRMSn/1mpRXoWvOBhVrqPtzm3ZE9x8MdKB2b+khiGi7jiOiF5xsr9RwuMgolqltv
         RWSbfmhjcMdoSODylCvCAC2cPEvAWC3Mkz0FlGc40f6DXpfCzr2gPddSlR1SRk0aqmgp
         3srE3b74n4075FDcWMVpuzysJw+AJfAEzOk+rhFDqnD8UKgH7z2yVC99LKIGolwfqo1W
         y1pqljUz+vqU6gt5UZtPXVcmA0dTefHemGn3YMcrG2hl3cYOe+hiNlxs2dvjR3jDp+wS
         Nmvw==
X-Gm-Message-State: ABy/qLZpbd2MCAy/HmgqDSyFQrHYjZQbsjB+zaYBp5RxQjYB4yK6Df/q
	YkuAR+FOyvPeXKbA7NFBdVxJOc/DqnPOhERH3mPgePzRxPt05BZrR71VJPaWegeSbfIdH04Arzv
	r2DQrJ+VmvT07uvVsDYQSLfjTsOQV
X-Received: by 2002:a19:501d:0:b0:4f8:6e6e:4100 with SMTP id e29-20020a19501d000000b004f86e6e4100mr1772924lfb.52.1688662106866;
        Thu, 06 Jul 2023 09:48:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEwZNNAMw0NtBAtrx170u/yb58eNGK9ZeL+P2bvqcNtSCBHfcCtRrQQoe0dDEeesNwOuihlSw==
X-Received: by 2002:a19:501d:0:b0:4f8:6e6e:4100 with SMTP id e29-20020a19501d000000b004f86e6e4100mr1772907lfb.52.1688662106426;
        Thu, 06 Jul 2023 09:48:26 -0700 (PDT)
Date: Thu, 6 Jul 2023 12:48:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
	marcandre.lureau@redhat.com, stefanha@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <20230706124347-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20230704123600.1808604-1-alex.bennee@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user

On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> Currently QEMU has to know some details about the back-end to be able
> to setup the guest. While various parts of the setup can be delegated
> to the backend (for example config handling) this is a very piecemeal
> approach.

> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> which the back-end can advertise which allows a probe message to be
> sent to get all the details QEMU needs to know in one message.

The reason we do piecemeal is that these existing pieces can be reused
as others evolve or fall by wayside.

For example, I can think of instances where you want to connect
specifically to e.g. networking backend, and specify it
on command line. Reasons could be many, e.g. for debugging,
or to prevent connecting to wrong device on wrong channel
(kind of like type safety).

What is the reason to have 1 message? startup latency?
How about we allow pipelining several messages then?
Will be easier.


> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> Initial RFC for discussion. I intend to prototype this work with QEMU
> and one of the rust-vmm vhost-user daemons.
> ---
>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost-user.c      |  8 ++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..85b1b1583a 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -275,6 +275,21 @@ Inflight description
>  
>  :queue size: a 16-bit size of virtqueues
>  
> +Backend specifications
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-----------+-------------+------------+------------+
> +| device id | config size |   min_vqs  |   max_vqs  |
> ++-----------+-------------+------------+------------+
> +
> +:device id: a 32-bit value holding the VirtIO device ID
> +
> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
> +
> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
> +
> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
> +

looks like a weird set of info.
why would we want # of vqs and not their sizes?
why config size but not config itself?




>  C structure
>  -----------
>  
> @@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>            VhostUserConfig config;
>            VhostUserVringArea area;
>            VhostUserInflight inflight;
> +          VhostUserBackendSpecs specs;
>        };
>    } QEMU_PACKED VhostUserMsg;
>  
> @@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
>  * ``VHOST_USER_GET_VRING_BASE``
>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
>  
>  .. seealso::
>  
> @@ -885,6 +902,13 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> +  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
> +
> +Some features are only valid in the presence of other supporting
> +features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
> +backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
> +``VHOST_USER_PROTOCOL_F_STATUS``.
> +
>  
>  Front-end message types
>  -----------------------
> @@ -1440,6 +1464,19 @@ Front-end message types
>    query the back-end for its device status as defined in the Virtio
>    specification.
>  
> +``VHOST_USER_GET_BACKEND_SPECS``
> +  :id: 41
> +  :request payload: N/A
> +  :reply payload: ``Backend specifications``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_STANDALONE`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end to
> +  query the back-end for its capabilities. This is intended to remove
> +  the need for the front-end to know ahead of time what the VirtIO
> +  device the backend emulates is.
> +
> +  The reply contains the device id, size of the config space and the
> +  range of VirtQueues the backend supports.
>  
>  Back-end message types
>  ----------------------
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index c4e0cbd702..28b021d5d3 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>  
> +typedef struct VhostUserBackendSpecs {
> +    uint32_t device_id;
> +    uint32_t config_size;
> +    uint32_t min_vqs;
> +    uint32_t max_vqs;
> +} VhostUserBackendSpecs;
> +
>  typedef struct {
>      VhostUserRequest request;
>  
> @@ -226,6 +233,7 @@ typedef union {
>          VhostUserCryptoSession session;
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
> +        VhostUserBackendSpecs specs;
>  } VhostUserPayload;
>  
>  typedef struct VhostUserMsg {
> -- 
> 2.39.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

