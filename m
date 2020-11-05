Return-Path: virtio-comment-return-1498-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <61930337391bdfd23ed164288d998c04177bc839.1603435652.git.jie.deng@intel.com>
 <20201023115932-mutt-send-email-mst@kernel.org>
 <a4a8ee83-d3e6-df1f-c0ac-f608d563522e@intel.com>
 <20201027071957-mutt-send-email-mst@kernel.org>
 <d0a26ef6-09a7-9cb3-73d3-b68a22cfee28@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <a7c27a1d-eca7-f0a6-0bcc-4fdbb9d7a001@intel.com>
Date: Thu, 5 Nov 2020 14:35:08 +0800
MIME-Version: 1.0
In-Reply-To: <d0a26ef6-09a7-9cb3-73d3-b68a22cfee28@redhat.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v2] virtio-i2c: add the device
 specification
Content-Type: multipart/alternative;
 boundary="------------A9E8011E07C5A01F1817F4DD"
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------A9E8011E07C5A01F1817F4DD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2020/10/31 21:58, Paolo Bonzini wrote:
> On 27/10/20 12:20, Michael S. Tsirkin wrote:
>>> The I2C doesn't support segments numbering and sorting.
>>> So if one creates a multi-segment transaction, then he/she should keep the
>>> segments in order.
>>>
>>> Thanks.
>> Fine, but I see no flags to signal start/end of such a transaction.
>>
> In theory there's no difference between one multi-segment transaction
> and many single-segment transactions _in a single-master scenario_.
>
> However, it is a plausible configuration to have multiple guests sharing
> an I2C host device as if they were multiple master.
>
> For this reason, I would prefer to have at least support for
> transactions with 1 write and 1 read segment to the same address (see my
> other message).
>
> Paolo
Then how to distinguish the order of the two segments if they are in one 
request ?
We don't know this is a write followed by a read or a read followed by a 
write in this case.

However, if the request is the representation of only one segment of an 
I2C transaction,
we can simply judge by the order of the requests in the virtqueue.

Thanks


--------------A9E8011E07C5A01F1817F4DD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2020/10/31 21:58, Paolo Bonzini
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:d0a26ef6-09a7-9cb3-73d3-b68a22cfee28@redhat.com">
      <pre class="moz-quote-pre" wrap="">On 27/10/20 12:20, Michael S. Tsirkin wrote:
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">The I2C doesn't support segments numbering and sorting.
So if one creates a multi-segment transaction, then he/she should keep the
segments in order.

Thanks.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Fine, but I see no flags to signal start/end of such a transaction.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
In theory there's no difference between one multi-segment transaction
and many single-segment transactions _in a single-master scenario_.

However, it is a plausible configuration to have multiple guests sharing
an I2C host device as if they were multiple master.

For this reason, I would prefer to have at least support for
transactions with 1 write and 1 read segment to the same address (see my
other message).

Paolo
</pre>
    </blockquote>
    Then how to distinguish the order of the two segments if they are in
    one request ?<br>
    We don't know this is a write followed by a read or a read followed
    by a write in this case.<br>
    <span class="fontstyle0"></span><br>
    <span class="fontstyle0">However, if the request is the
      representation of only one segment of an I2C transaction,</span><br>
    <span class="fontstyle0">we can simply judge by the order of the
      requests in the virtqueue.</span>
    <p><span class="fontstyle0">Thanks<br>
      </span></p>
    <p><span class="fontstyle0"></span></p>
    <blockquote type="cite"
      cite="mid:d0a26ef6-09a7-9cb3-73d3-b68a22cfee28@redhat.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------A9E8011E07C5A01F1817F4DD--

