Return-Path: <virtio-dev-return-13261-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB95CEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:31:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 27A723F8E7
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:31:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A3D79867B6
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:31:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E6C1F986728; Thu,  6 Jul 2023 16:31:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1F7B986729
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 16:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688661112; x=1691253112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oeN++xGg8e35F2/9iu+dQUFgpJqc7z1W6P3YqcVFJOE=;
        b=dqNB7X0aPqB7FBhUi5wCtoVVOJd5j0UDaA0UBtMzIlLpuvRPA9fQpWGEwS+YwqbfDm
         vkrRUcREP932wf6coUzMiEfcuzCVLWiLcccmZB3uGRhT6fP/V2HTBsnejg3pDzKcMH/R
         W2L1x7qqM4daCDdHTBnTmbCNroVIfbZs/gQrIIJu995ntNEgw4t7Q32ePlzc1BUXhIlv
         cK4bwXqGu4O6ycnsu+0iiDMaV5ZpmG1DcyHBSX0hpGJGAWIF/+OM1loyvOdIDG1cYAo8
         hLNz3ZVhQ0roSj10pigLb4n5oWbukcuouYEh5dycntDzYAIB1F88xMlU0XEiN7TE4J6T
         6XOA==
X-Gm-Message-State: ABy/qLYHPRtdnEPJ74xRSapys4NokA/7jQt+SHt2ScvO5POEOb1q/Qn7
	PHLEn528Sot3MvOMnseohFz6Fg==
X-Google-Smtp-Source: APBJJlF1Iu5C6Ts+ksT1Js2KXqV/lcpvvQYluNMhRCdEbsAMS2K8fa/jEnZG+hCERq+/EyXuEF/a9g==
X-Received: by 2002:a5d:5444:0:b0:314:1fdc:796d with SMTP id w4-20020a5d5444000000b003141fdc796dmr1805250wrv.70.1688661111900;
        Thu, 06 Jul 2023 09:31:51 -0700 (PDT)
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org
Date: Thu, 06 Jul 2023 17:31:15 +0100
In-reply-to: <20230704123600.1808604-1-alex.bennee@linaro.org>
Message-ID: <873521f1c9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature
 for vhost-user


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Currently QEMU has to know some details about the back-end to be able
> to setup the guest. While various parts of the setup can be delegated
> to the backend (for example config handling) this is a very piecemeal
> approach.
>
> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> which the back-end can advertise which allows a probe message to be
> sent to get all the details QEMU needs to know in one message.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
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
>=20=20
>  :queue size: a 16-bit size of virtqueues
>=20=20
> +Backend specifications
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-----------+-------------+------------+------------+
> +| device id | config size |   min_vqs  |   max_vqs  |
> ++-----------+-------------+------------+------------+
> +
> +:device id: a 32-bit value holding the VirtIO device ID
> +
> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_G=
ET_CONFIG``)
> +
> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
> +
> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, mu=
st be >=3D min_vqs
> +
>  C structure
>  -----------
>=20=20
> @@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserConfig config;
>            VhostUserVringArea area;
>            VhostUserInflight inflight;
> +          VhostUserBackendSpecs specs;
>        };
>    } QEMU_PACKED VhostUserMsg;
>=20=20
> @@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
>  * ``VHOST_USER_GET_VRING_BASE``
>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SH=
MFD``)
> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALON=
E``)
>=20=20
>  .. seealso::
>=20=20
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

This is too tight a restriction as not all VirtIO backends manage a
config space. So I suggest the following:

  Some features are only valid in the presence of other supporting
  features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
  backend must also support ``VHOST_USER_PROTOCOL_F_STATUS`` and
  optionally ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

