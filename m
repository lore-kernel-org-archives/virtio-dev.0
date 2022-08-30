Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <d8a5b3ed-674c-90f9-16a8-467599e06ee7@linux.alibaba.com>
Date: Tue, 30 Aug 2022 19:23:03 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v7] virtio_net: support split header
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <87v8qgo118.fsf@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <87v8qgo118.fsf@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------0CUAaUjFymz92hbp0MlI7eVh"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is a multi-part message in MIME format.
--------------0CUAaUjFymz92hbp0MlI7eVh
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

在 2022/8/25 下午10:22, Cornelia Huck 写道:
> On Tue, Aug 16 2022, Heng Qi<hengqi@linux.alibaba.com>  wrote:
>
>> From: Xuan Zhuo<xuanzhuo@linux.alibaba.com>
>>
>> The purpose of this feature is to split the header and the payload of
>> the packet.
>>
>> |                    receive buffer                                    |
>> |                       0th descriptor             | 1th descriptor    |
>> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         |
>>
>> We can use a buffer plus a separate page when allocating the receive
>> buffer. In this way, we can ensure that all payloads can be
>> independently in a page, which is very beneficial for the zerocopy
>> implemented by the upper layer.
>>
>> Signed-off-by: Xuan Zhuo<xuanzhuo@linux.alibaba.com>
>> Signed-off-by: Heng Qi<hengqi@linux.alibaba.com>
>> Reviewed-by: Kangjie Xu<kangjie.xu@linux.alibaba.com>
>> ---
>> v7:
>> 	1. Fix some presentation issues.
>> 	2. Use "split transport header". @Jason Wang
>> 	3. Clarify some paragraphs. @Cornelia Huck
>> 	4. determine the device what to do if it does not perform header split on a packet.
>>
>> v6:
>> 	1. Fix some syntax issues. @Cornelia Huck
>> 	2. Clarify some paragraphs. @Cornelia Huck
>> 	3. Determine the device what to do if it does not perform header split on a packet.
>>
>> v5:
>> 	1. Determine when hdr_len is credible in the process of rx
>> 	2. Clean up the use of buffers and descriptors
>> 	3. Clarify the meaning of used lenght if the first descriptor is skipped in the case of merge
>>
>> v4:
>> 	1. fix typo @Cornelia Huck @Jason Wang
>> 	2. do not split header for IP fragmentation packet. @Jason Wang
>>
>> v3:
>> 	1. Fix some syntax issues
>> 	2. Fix some terminology issues
>> 	3. It is not unified with ip alignment, so ip alignment is not included
>> 	4. Make it clear that the device must support four types, in the case of successful negotiation.
>>
>>   conformance.tex |   2 ++
>>   content.tex     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 104 insertions(+)
> I do not have any further comments on the change, let's see what the
> networking folks think.

Okay. Thanks for your review.

>
> [Do we require patches to be posted to virtio-comment, or is virtio-dev
> enough? I'm a bit unsure right now.]

We can then consider posting patches to virtio-comment.

--------------0CUAaUjFymz92hbp0MlI7eVh
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>
</pre>
    <div class="moz-cite-prefix">在 2022/8/25 下午10:22, Cornelia Huck 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:87v8qgo118.fsf@redhat.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Aug 16 2022, Heng Qi <a class="moz-txt-link-rfc2396E" href="mailto:hengqi@linux.alibaba.com">&lt;hengqi@linux.alibaba.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">From: Xuan Zhuo <a class="moz-txt-link-rfc2396E" href="mailto:xuanzhuo@linux.alibaba.com">&lt;xuanzhuo@linux.alibaba.com&gt;</a>

The purpose of this feature is to split the header and the payload of
the packet.

|                    receive buffer                                    |
|                       0th descriptor             | 1th descriptor    |
| virtnet hdr | mac | ip hdr | tcp hdr|&lt;-- hold --&gt;|   payload         |

We can use a buffer plus a separate page when allocating the receive
buffer. In this way, we can ensure that all payloads can be
independently in a page, which is very beneficial for the zerocopy
implemented by the upper layer.

Signed-off-by: Xuan Zhuo <a class="moz-txt-link-rfc2396E" href="mailto:xuanzhuo@linux.alibaba.com">&lt;xuanzhuo@linux.alibaba.com&gt;</a>
Signed-off-by: Heng Qi <a class="moz-txt-link-rfc2396E" href="mailto:hengqi@linux.alibaba.com">&lt;hengqi@linux.alibaba.com&gt;</a>
Reviewed-by: Kangjie Xu <a class="moz-txt-link-rfc2396E" href="mailto:kangjie.xu@linux.alibaba.com">&lt;kangjie.xu@linux.alibaba.com&gt;</a>
---
v7:
	1. Fix some presentation issues.
	2. Use "split transport header". @Jason Wang
	3. Clarify some paragraphs. @Cornelia Huck
	4. determine the device what to do if it does not perform header split on a packet.

v6:
	1. Fix some syntax issues. @Cornelia Huck
	2. Clarify some paragraphs. @Cornelia Huck
	3. Determine the device what to do if it does not perform header split on a packet.

v5:
	1. Determine when hdr_len is credible in the process of rx
	2. Clean up the use of buffers and descriptors
	3. Clarify the meaning of used lenght if the first descriptor is skipped in the case of merge

v4:
	1. fix typo @Cornelia Huck @Jason Wang
	2. do not split header for IP fragmentation packet. @Jason Wang

v3:
	1. Fix some syntax issues
	2. Fix some terminology issues
	3. It is not unified with ip alignment, so ip alignment is not included
	4. Make it clear that the device must support four types, in the case of successful negotiation.

 conformance.tex |   2 ++
 content.tex     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I do not have any further comments on the change, let's see what the
networking folks think.</pre>
    </blockquote>
    <pre>
Okay. Thanks for your review.

</pre>
    <blockquote type="cite" cite="mid:87v8qgo118.fsf@redhat.com">
      <pre class="moz-quote-pre" wrap="">

[Do we require patches to be posted to virtio-comment, or is virtio-dev
enough? I'm a bit unsure right now.]
</pre>
    </blockquote>
    <pre>
We can then consider posting patches to virtio-comment.

</pre>
  </body>
</html>

--------------0CUAaUjFymz92hbp0MlI7eVh--

