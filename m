Return-Path: <virtio-dev-return-11636-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84A6C7618B
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 16:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D12E044365
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 16:20:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A79AB986431
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 16:20:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 97DC1986413; Wed, 15 Mar 2023 16:20:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80E4198641B
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 16:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 01A_jSoPMI6kOcWOXQpnMw-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 jasowang@redhat.com
In-Reply-To: <20230315120359-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230310062613.109867-1-Igor.Skalkin@opensynergy.com>
 <20230310062613.109867-2-Igor.Skalkin@opensynergy.com>
 <87edpqt3e8.fsf@redhat.com>
 <20230315120359-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 15 Mar 2023 17:20:09 +0100
Message-ID: <87bkkut29y.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 1/1] RFC: virtio-bt: add virtio BT
 device specification

On Wed, Mar 15 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 15, 2023 at 04:55:59PM +0100, Cornelia Huck wrote:
>> On Fri, Mar 10 2023, Igor Skalkin <Igor.Skalkin@opensynergy.com> wrote:
>> > +\subsection{Feature bits}\label{sec:Device Types / BT Device / Feature bits}
>> > +
>> > +\begin{description}
>> > +\item[VIRTIO_BT_F_VND_HCI (0)]  Indicates vendor command support.
>> > +\item[VIRTIO_BT_F_MSFT_EXT (1)] Indicates MSFT vendor support.
>> > +\item[VIRTIO_BT_F_AOSP_EXT (2)] Indicates AOSP vendor support.
>> > +\item[VIRTIO_BT_F_CONFIG_V2 (3)] The device uses the second version of the
>> > +configuration space structure.
>> > +\end{description}
>> > +
>> > +\devicenormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
>> > +
>> > +The device MUST require the driver to accept the VIRTIO_BT_F_CONFIG_V2 feature
>> > +bit, i.e. not set FEATURES_OK without it, and use the second version
>> > +(struct virtio_bt_config_v2) of the configuration layout, because the
>> > +first one (struct virtio_bt_config) is unaligned, which violates the
>> > +specification.
>> 
>> Did we have a device or driver that didn't use v2? I'm not sure we want
>> to add a feature for that, other than for backwards compatibility.
>
> Linux drivers use a different layout, yes.

Oh, indeed.

>
> I think it should be possible to implement device without
> VIRTIO_BT_F_CONFIG_V2 if someone wants to be compatible.

So, do we need to downgrade the requirements for this feature to SHOULD?

>
> And hmm we need to get back to addressing the negotiation mess ...


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

