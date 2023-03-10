Return-Path: <virtio-dev-return-11600-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3037AC6FD1F
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 14:05:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DEFB31EDFA
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 14:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0B12986728
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 14:05:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3D3498671F; Fri, 10 Mar 2023 14:05:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE0BD98671D;
	Fri, 10 Mar 2023 14:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Fri, 10 Mar 2023 15:05:11 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
        virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230310150511.3d68aad7.pasic@linux.ibm.com>
In-Reply-To: <20230309115110-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
	<87a60z5wes.fsf@redhat.com>
	<20230301182207.23f995cd.pasic@linux.ibm.com>
	<20230301123044-mutt-send-email-mst@kernel.org>
	<87a60vmbub.fsf@redhat.com>
	<20230303023949-mutt-send-email-mst@kernel.org>
	<20230303224937.62fe64b9.pasic@linux.ibm.com>
	<20230305043948-mutt-send-email-mst@kernel.org>
	<20230309174650.7093f020.pasic@linux.ibm.com>
	<20230309115110-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FGcFpQ3wVZ8Rm5dwsev3kTguKCvoxjqL
X-Proofpoint-GUID: grMPylRdiZmH_X2StRACN_3LMlDYxTG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=940
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100113
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue
 index to queue number

On Thu, 9 Mar 2023 11:53:34 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Anyway, both "number" and "index" require cleanup work, whoever
> is going to do it gets to decide which way it will go

Makes sense! Thank you!

Regards,
Halil

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

