Return-Path: virtio-dev-return-6230-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C4A8985E3C
	for <virtio-dev@lists.oasis-open.org>; Sat, 12 Oct 2019 07:20:04 +0000 (UTC)
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <19cb1e74-66ac-3658-ff01-1414b5039158@siemens.com>
Date: Sat, 12 Oct 2019 09:20:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] virtio-spec: Clarify /wrt maintaining a split-queue descriptors
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi all,

I'm wondering if the spec is clear enough regarding who is in charge of
setting fields in a descriptor of split virtqueues. Background: I just
made the mistake in an experimental backend of writing back the number
of bytes pushed into a buffer not only in virtq_used_elem but also the
referenced virtq_desc - with unpleasant effects for the guest.

The spec in section 2.6.8 reads to me like virtq_used_elem.len is rather
informative. At least this section leaves it fuzzy to me whether there
are other sources from where a driver can find out how much a device has
delivered - and misled me to also update virtq_desc.len in the device.

But maybe I'm missing a clear note in another section.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

