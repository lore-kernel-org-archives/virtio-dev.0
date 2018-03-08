Return-Path: virtio-dev-return-3474-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DFDEA58180EF
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Mar 2018 19:46:46 -0800 (PST)
References: <cover.1519961667.git.jbaron@akamai.com>
 <864430f2a613c4d3c82b591ed7bc27068ddad369.1519961667.git.jbaron@akamai.com>
 <20180302195256-mutt-send-email-mst@kernel.org>
 <a44eda0c-7f5b-ad31-f357-730fb62afb77@akamai.com>
 <20180306201354-mutt-send-email-mst@kernel.org>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <2477b427-76bb-93fa-507a-d37cca371a2a@akamai.com>
Date: Wed, 7 Mar 2018 22:46:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180306201354-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH 1/4] eth: add speed and duplex definitions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 03/06/2018 01:15 PM, Michael S. Tsirkin wrote:
> On Tue, Mar 06, 2018 at 12:53:14PM -0500, Jason Baron wrote:
>>
>>
>> On 03/02/2018 12:54 PM, Michael S. Tsirkin wrote:
>>> On Thu, Mar 01, 2018 at 10:46:33PM -0500, Jason Baron wrote:
>>>> Pull in definitions for SPEED_UNKNOWN, DUPLEX_UNKNOWN, DUPLEX_HALF,
>>>> and DUPLEX_FULL.
>>>>
>>>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>> Cc: virtio-dev@lists.oasis-open.org
>>>> ---
>>>>  include/net/eth.h | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/include/net/eth.h b/include/net/eth.h
>>>> index 09054a5..9843678 100644
>>>> --- a/include/net/eth.h
>>>> +++ b/include/net/eth.h
>>>> @@ -417,4 +417,11 @@ bool
>>>>  eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>>>>                     size_t ip6hdr_off, eth_ip6_hdr_info *info);
>>>>  
>>>> +/* ethtool defines - from linux/ethtool.h */
>>>> +#define SPEED_UNKNOWN           -1
>>>> +
>>>> +#define DUPLEX_HALF             0x00
>>>> +#define DUPLEX_FULL             0x01
>>>> +#define DUPLEX_UNKNOWN          0xff
>>>> +
>>>>  #endif
>>>
>>> While that's not a lot, I think we should import linux/ethtool.h into
>>> include/standard-headers/linux/ using scripts/update-linux-headers.sh
>>>
>>
>> Ok, I had started down that path, by including
>> include/uapi/linux/ethtool.h but that resulted in a few other headers -
>> kernel.h, sysinfo.h. And so it seemed like a lot of headers for only a
>> few lines. But I will re-visit it...
>>
>> Thanks,
>>
>> -Jason
> 
> I don't know why is sysinfo there. Want to try sending a patch to
> drop it from linux/kernel.h?
> 

Seems like this also ripples into glibc headers, if you look at:
/usr/include/x86_64-linux-gnu/sys/sysinfo.h. It also includes kernel.h
in order to get struct sysinfo. So that would need updating as well.

I've done a v2 that just pulls in sysinfo.h, it doesn't look too bad,
but let me know...

Thanks,

-Jason


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

