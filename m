Return-Path: virtio-comment-return-1593-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201216155218.GA720702@stefanha-x1.localdomain>
 <b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
 <20201217030015-mutt-send-email-mst@kernel.org>
 <20201217102640.GG4338@stefanha-x1.localdomain>
 <1ccc5889-4e28-deac-8168-c6f0665231c1@intel.com>
 <20201218155526-mutt-send-email-mst@kernel.org>
 <20b91229-e938-66fb-464b-c85c1dbcde96@intel.com>
 <20201222122909.3168620a.cohuck@redhat.com>
 <20201222172847-mutt-send-email-mst@kernel.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <927cab6a-11b0-ee0b-9215-a3a7046f74d5@intel.com>
Date: Thu, 24 Dec 2020 16:15:14 +0800
MIME-Version: 1.0
In-Reply-To: <20201222172847-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: multipart/alternative;
 boundary="------------3F97F6004747FD7C4519FA14"
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------3F97F6004747FD7C4519FA14
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2020/12/23 6:31, Michael S. Tsirkin wrote:
> On Tue, Dec 22, 2020 at 12:29:09PM +0100, Cornelia Huck wrote:
>> Is there any reason why we need to infer the type of the request by
>> checking some lengths? Can't we just specify explicit flags for read
>> and write? What am I missing?
> Point is descriptors already have flags for read/write.
> If there is a read buffer and length > sizeof virtio_i2c_in_hdr then
> we know it's a read request.
> If there is a write buffer and length > sizeof virtio_i2c_out_hdr then
> we know it's a write request.
> If both then both.
>
> All this is known before buffer itself is consumed, which is nice.
>
> Putting this info in flags will duplicate info which is often
> a source of errors.
>
Sent the v6 with field written/read removed.
>


--------------3F97F6004747FD7C4519FA14
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2020/12/23 6:31, Michael S. Tsirkin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20201222172847-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Tue, Dec 22, 2020 at 12:29:09PM +0100, Cornelia Huck wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <pre class="moz-quote-pre" wrap="">
Is there any reason why we need to infer the type of the request by
checking some lengths? Can't we just specify explicit flags for read
and write? What am I missing?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Point is descriptors already have flags for read/write.
If there is a read buffer and length &gt; sizeof virtio_i2c_in_hdr then
we know it's a read request.
If there is a write buffer and length &gt; sizeof virtio_i2c_out_hdr then
we know it's a write request.
If both then both.

All this is known before buffer itself is consumed, which is nice.

Putting this info in flags will duplicate info which is often
a source of errors.

</pre>
    </blockquote>
    Sent the v6 with field <span class="fontstyle0">written</span>/read
    removed.
    <br style=" font-style: normal; font-variant: normal; font-weight:
      normal; letter-spacing: normal; line-height: normal; orphans: 2;
      text-align: -webkit-auto; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; ">
    <blockquote type="cite"
      cite="mid:20201222172847-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------3F97F6004747FD7C4519FA14--

