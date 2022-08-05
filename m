Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <270139d6-1c00-9cd4-1ea9-b6f9769fedb8@linux.alibaba.com>
Date: Fri, 5 Aug 2022 13:59:18 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH] virtio_net: support split header
References: <1659337182-128890-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.com>
 <8ab46a3e-8f00-e05f-0dca-d0009164aa16@linux.alibaba.com>
 <87bkt086ef.fsf@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <87bkt086ef.fsf@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------V2bjciu2B0YAZQnOMvZeRLrF"
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This is a multi-part message in MIME format.
--------------V2bjciu2B0YAZQnOMvZeRLrF
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


在 2022/8/4 下午9:50, Cornelia Huck 写道:
> On Thu, Aug 04 2022, Heng Qi<hengqi@linux.alibaba.com>  wrote:
>
>> 在 2022/8/4 下午2:27, Jason Wang 写道:
>>> On Mon, Aug 1, 2022 at 2:59 PM Heng Qi<hengqi@linux.alibaba.com>   wrote:
>>>> @@ -3820,9 +3826,13 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>>>    driver MUST NOT use the \field{csum_start} and \field{csum_offset}.
>>>>
>>>>    If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
>>>> -been negotiated, the driver MAY use \field{hdr_len} only as a hint about the
>>>> +been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
>>>> +is not set, the driver MAY use \field{hdr_len} only as a hint about the
>>>>    transport header size.
>>>> -The driver MUST NOT rely on \field{hdr_len} to be correct.
>>>> +
>>>> +If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is not set, the driver
>>>> +MUST NOT rely on \field{hdr_len} to be correct.
>>> I think we should keep the above description as-is. For whatever case,
>>> the driver must not trust the metadata set by the device and must
>>> perform necessary sanity tests on them.
>>
>> My idea is to keep the current description as it is,
>> but to emphasize in the next version:
>> "If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set,
>> the driver MAY treat the \field{hdr_len} as the length of the
>> protocol header inside the first descriptor."
>
> Just to be clear, you suggest using
>
> "If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
> been negotiated, the driver MAY use \field{hdr_len} only as a hint about the
> transport header size.
>
> The driver MUST NOT rely on \field{hdr_len} to be correct.
>
> If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set,
> the driver MAY treat the \field{hdr_len} as the length of the
> protocol header inside the first descriptor."

Yes. I will use the above description to make it clearer in the next version.


>
> (Maybe "...the driver MAY use \field{hdr_len} as a hint about the length
> of the protocol header..."? It's still not reliable, right?)
>
\field{hdr_len} is unreliable when VIRTIO_NET_F_SPLIT_HEADER is not negotiated.


If VIRTIO_NET_F_SPLIT_HEADER is negotiated, "split header" MAY perform the split
from the IP layer, so the protocol header and the transport header are different.

so I think the "...the driver MAY use \field{hdr_len} only as a hint about the
transport header size..." paragraph can be left as-is.



--------------V2bjciu2B0YAZQnOMvZeRLrF
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2022/8/4 下午9:50, Cornelia Huck 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:87bkt086ef.fsf@redhat.com">
      <pre class="moz-quote-pre" wrap="">On Thu, Aug 04 2022, Heng Qi <a class="moz-txt-link-rfc2396E" href="mailto:hengqi@linux.alibaba.com">&lt;hengqi@linux.alibaba.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">在 2022/8/4 下午2:27, Jason Wang 写道:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Mon, Aug 1, 2022 at 2:59 PM Heng Qi<a class="moz-txt-link-rfc2396E" href="mailto:hengqi@linux.alibaba.com">&lt;hengqi@linux.alibaba.com&gt;</a>  wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">@@ -3820,9 +3826,13 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
  driver MUST NOT use the \field{csum_start} and \field{csum_offset}.

  If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
-been negotiated, the driver MAY use \field{hdr_len} only as a hint about the
+been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
+is not set, the driver MAY use \field{hdr_len} only as a hint about the
  transport header size.
-The driver MUST NOT rely on \field{hdr_len} to be correct.
+
+If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is not set, the driver
+MUST NOT rely on \field{hdr_len} to be correct.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I think we should keep the above description as-is. For whatever case,
the driver must not trust the metadata set by the device and must
perform necessary sanity tests on them.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">

My idea is to keep the current description as it is,
but to emphasize in the next version:
"If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set,
the driver MAY treat the \field{hdr_len} as the length of the
protocol header inside the first descriptor."
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

Just to be clear, you suggest using

"If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
been negotiated, the driver MAY use \field{hdr_len} only as a hint about the
transport header size.

The driver MUST NOT rely on \field{hdr_len} to be correct.

If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set,
the driver MAY treat the \field{hdr_len} as the length of the
protocol header inside the first descriptor."</pre>
    </blockquote>
    <pre>
Yes. I will use the above description to make it clearer in the next version.


</pre>
    <blockquote type="cite" cite="mid:87bkt086ef.fsf@redhat.com">
      <pre class="moz-quote-pre" wrap="">

(Maybe "...the driver MAY use \field{hdr_len} as a hint about the length
of the protocol header..."? It's still not reliable, right?)

<pre>
</pre></pre>
    </blockquote>
    <pre>
\field{hdr_len} is unreliable when VIRTIO_NET_F_SPLIT_HEADER is not negotiated.


If VIRTIO_NET_F_SPLIT_HEADER is negotiated, "split header" MAY perform the split
from the IP layer, so the protocol header and the transport header are different.

so I think the "...the driver MAY use \field{hdr_len} only as a hint about the
transport header size..." paragraph can be left as-is.



</pre>
  </body>
</html>

--------------V2bjciu2B0YAZQnOMvZeRLrF--

