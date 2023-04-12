Return-Path: <virtio-dev-return-12180-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF65C77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:10:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7276A41A0F
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:10:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 643CB9865ED
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:10:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 58C1098650F; Wed, 12 Apr 2023 05:10:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46BA098650E;
	Wed, 12 Apr 2023 05:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Wed, 12 Apr 2023 07:10:14 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230412071014.3c79f788.pasic@linux.ibm.com>
In-Reply-To: <20230330225834.506969-1-parav@nvidia.com>
References: <20230330225834.506969-1-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 96nIfi2Pk_3eyHyBPnKcxYBz-v7rLlyz
X-Proofpoint-GUID: dOTrysvqwz6fjSJjNWH3Npcy6kabFKHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120044
Subject: Re: [virtio-dev] [PATCH 00/11] Introduce transitional mmr pci
 device

On Fri, 31 Mar 2023 01:58:23 +0300
Parav Pandit <parav@nvidia.com> wrote:

> Overview:
> ---------
> The Transitional MMR device is a variant of the transitional PCI device.
> It has its own small Device ID range. It does not have I/O
> region BAR; instead it exposes legacy configuration and device
> specific registers at an offset in the memory region BAR.
> 

I have some conceptual problems with the current wording. I have to
admit the ongoing discussion is for me quite difficult to follow.
Nevertheless I have the feeling most of my concerns were already
voiced by mostly Michael.

 
[..]
> Please review.
> 

After reading trough everything, I have a feeling, I have at least a
basic understanding of what you are trying to accomplish. If you
don't mind I would prefer to wait for a v2, maybe things will
settle down a little by then. I feel like me commenting right now
would just muddy the waters even further, without any real merrit. But if
you insist, you can get some...

Regards,
Halil

[..]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

