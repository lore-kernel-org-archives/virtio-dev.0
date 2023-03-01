Return-Path: <virtio-dev-return-11347-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F8FC64ED6
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 17:22:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8156A41A13
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 17:22:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 764DE986671
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 17:22:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 688D198666C; Wed,  1 Mar 2023 17:22:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5421F98666D;
	Wed,  1 Mar 2023 17:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Wed, 1 Mar 2023 18:22:07 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20230301182207.23f995cd.pasic@linux.ibm.com>
In-Reply-To: <87a60z5wes.fsf@redhat.com>
References: <20230223054624.168042-1-parav@nvidia.com>
	<87a60z5wes.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ga1wSrIGbvxYigvO0jje6wpZCgjQoIPb
X-Proofpoint-ORIG-GUID: VmKJm6J-5d_tvIL_nK05Fem_3kBdqNtS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_13,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=896 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010141
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number

On Mon, 27 Feb 2023 09:45:31 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> For the vq index/number, I'm not that sure that "virtqueue number" is
> better that "virtqueue index" -- actually, I'd prefer the latter. We'd
> need some renaming either way.

I prefer index as well. Especially that we start indexing with 0. Also
seems to be the more common term for such stuff in both Mathematics and
CS.

Regards,
Halil 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

