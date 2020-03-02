Return-Path: virtio-dev-return-6830-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64BD5985B2F
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 04:31:45 +0000 (UTC)
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301150625-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <70ddcfd3-c388-1d5d-0728-4dbb434c619c@redhat.com>
Date: Mon, 2 Mar 2020 12:31:28 +0800
MIME-Version: 1.0
In-Reply-To: <20200301150625-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v3 0/3] virtio-net: introduce features defined in the spec
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yan@daynix.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/3/2 =E4=B8=8A=E5=8D=884:06, Michael S. Tsirkin wrote:
> On Sun, Mar 01, 2020 at 04:32:59PM +0200, Yuri Benditovich wrote:
>> This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
>> VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.
>>
>> Changes from v2: reformatted structure in patch 1
>
> Looks good but I cound a couple more nits. Sorry I missed them
> on the previous read.


Do we want to merge this without the actual users in kernel?

Thanks


>
>> Yuri Benditovich (3):
>>    virtio-net: Introduce extended RSC feature
>>    virtio-net: Introduce RSS receive steering feature
>>    virtio-net: Introduce hash report feature
>>
>>   include/uapi/linux/virtio_net.h | 100 ++++++++++++++++++++++++++++++--
>>   1 file changed, 96 insertions(+), 4 deletions(-)
>>
>> --=20
>> 2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

