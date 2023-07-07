Return-Path: <virtio-dev-return-13311-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0852EB64D9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 10:36:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3CCDD2B028
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 10:36:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F03398680C
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 10:36:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 07F5F9867EB; Fri,  7 Jul 2023 10:36:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E84039867F9
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 10:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: CQ8fBrGLOCu2a53d74GQUw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688726163; x=1691318163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77Uf3vHUJAUtylrUh6utMWDwWeM8+WpotWwHGq9xzO4=;
        b=E8wOXJfYdXPkRH4hjqBwVLCOcBucVc2v+NDlom87fR/m4Vc/87yR91WmYK6X7Snes6
         JR43EOmF1RrIn5agFn3VErDPL33lg7PD70WKkP/ejRPTMbggyMBCMIlr0hJNUYrmvSHs
         G/RV8VtzlPVQTOLH/J9i8OEK1b/QvbbRNu8sf9IjYqA9KljBkvTd3++GsITy6bTar2RH
         49b0voRmclLX5GD0urSFVTlga2QZfUTcVtu8m1wQvdXz5/a4ZWjQSaxpJCanxuM7mkVf
         3voRrcxrMCTLgy3exUtbUrpas9MDEQLhgek36djg3kFoGmdJ7N8c/pyZoCO4xF+r7xpq
         mLgg==
X-Gm-Message-State: ABy/qLZkx37FDPvTq0Nc/ws2nHOV89+j/TJmGLOaemCjXcR1Xf+Iy6Gw
	ImOd3ez4o8O8ESiOZFV90f/hnZaW0gWPX7+OQreV1vmhz8hXH3vB4AEzPZk14xObTFuXzHGD+jf
	5ha111kLXJHHIfw11kkP6DlF9C7ZB
X-Received: by 2002:a05:620a:2949:b0:767:18f8:7b20 with SMTP id n9-20020a05620a294900b0076718f87b20mr9308120qkp.19.1688726163442;
        Fri, 07 Jul 2023 03:36:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGIXyiqWjBdGdKFZwobESisxGkC5/+1q++28fKnfYLxaBHQde7VcYUssDCOcXuMkD32BS3Kfg==
X-Received: by 2002:a05:620a:2949:b0:767:18f8:7b20 with SMTP id n9-20020a05620a294900b0076718f87b20mr9308102qkp.19.1688726163158;
        Fri, 07 Jul 2023 03:36:03 -0700 (PDT)
Date: Fri, 7 Jul 2023 12:35:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, 
	mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, 
	viresh.kumar@linaro.org, takahiro.akashi@linaro.org, erik.schilling@linaro.org, 
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <pc4akdgo5njdrcokvtqjggd4aycfjrb6jobwgwk5cr6asr5zun@krowoff46yae>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <873521f1c9.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <873521f1c9.fsf@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user

On Thu, Jul 06, 2023 at 05:31:15PM +0100, Alex Bennée wrote:
>
>Alex Bennée <alex.bennee@linaro.org> writes:
>
>> Currently QEMU has to know some details about the back-end to be able
>> to setup the guest. While various parts of the setup can be delegated
>> to the backend (for example config handling) this is a very piecemeal
>> approach.
>>
>> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
>> which the back-end can advertise which allows a probe message to be
>> sent to get all the details QEMU needs to know in one message.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> Initial RFC for discussion. I intend to prototype this work with QEMU
>> and one of the rust-vmm vhost-user daemons.
>> ---
>>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>>  hw/virtio/vhost-user.c      |  8 ++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 5a070adbc1..85b1b1583a 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -275,6 +275,21 @@ Inflight description
>>
>>  :queue size: a 16-bit size of virtqueues
>>
>> +Backend specifications
>> +^^^^^^^^^^^^^^^^^^^^^^
>> +
>> ++-----------+-------------+------------+------------+
>> +| device id | config size |   min_vqs  |   max_vqs  |
>> ++-----------+-------------+------------+------------+
>> +
>> +:device id: a 32-bit value holding the VirtIO device ID
>> +
>> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
>> +
>> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
>> +
>> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
>> +
>>  C structure
>>  -----------
>>
>> @@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>>            VhostUserConfig config;
>>            VhostUserVringArea area;
>>            VhostUserInflight inflight;
>> +          VhostUserBackendSpecs specs;
>>        };
>>    } QEMU_PACKED VhostUserMsg;
>>
>> @@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
>>  * ``VHOST_USER_GET_VRING_BASE``
>>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
>> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
>>
>>  .. seealso::
>>
>> @@ -885,6 +902,13 @@ Protocol features
>>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>> +  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
>> +
>> +Some features are only valid in the presence of other supporting
>> +features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
>> +backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
>> +``VHOST_USER_PROTOCOL_F_STATUS``.
>> +
>
>This is too tight a restriction as not all VirtIO backends manage a
>config space. So I suggest the following:
>
>  Some features are only valid in the presence of other supporting
>  features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
>  backend must also support ``VHOST_USER_PROTOCOL_F_STATUS`` and
>  optionally ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space).

Right, but could we describe it more as a kind of dependence between
features?

Something like this:

Some features depend on others to be supported:

* ``VHOST_USER_PROTOCOL_F_STANDALONE`` depends on:

   * ``VHOST_USER_PROTOCOL_F_STATUS``
   * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)

Thanks,
Stefano


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

