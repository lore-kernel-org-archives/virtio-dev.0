Return-Path: virtio-comment-return-1478-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <5d3d8a27893734be954ebbe560f638fbafb3429c.1603778046.git.jie.deng@intel.com>
 <20201027081406-mutt-send-email-mst@kernel.org>
 <752795c8-868a-add0-30c0-9d34e542140c@intel.com>
 <20201028072253-mutt-send-email-mst@kernel.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <3d9187b6-117b-9658-e3ad-33d409e9473c@intel.com>
Date: Thu, 29 Oct 2020 10:20:10 +0800
MIME-Version: 1.0
In-Reply-To: <20201028072253-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [PATCH v3] virtio-i2c: add the device specification
Content-Type: multipart/alternative;
 boundary="------------0C3A72F49573A16C88CB0272"
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--------------0C3A72F49573A16C88CB0272
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2020/10/28 19:27, Michael S. Tsirkin wrote:

> On Wed, Oct 28, 2020 at 03:54:39PM +0800, Jie Deng wrote:
>> On 2020/10/27 20:20, Michael S. Tsirkin wrote:
>>> On Tue, Oct 27, 2020 at 02:00:24PM +0800, Jie Deng wrote:
>>>> virtio-i2c is a virtual I2C adapter device. It provides a way
>>>> to =EF=AC=82exibly communicate with the I2C slave devices from the gue=
st.
>>>>
>>>> This patch adds the specification for this device.
>>>>
>>>> Signed-off-by: Jie Deng<jie.deng@intel.com>
>>>> ---
>>>>    conformance.tex | 28 ++++++++++++++---
>>>>    content.tex     |  1 +
>>>>    virtio-i2c.tex  | 94 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>>>    3 files changed, 119 insertions(+), 4 deletions(-)
>>>>    create mode 100644 virtio-i2c.tex
>>>>
>>>> +The driver queues requests to the virtqueue, and they are used by the
>>>> +device. The request is the representation of one segment of an I2C
>>>> +transaction. Each request is of form:
>>>> +
>>>> +\begin{lstlisting}
>>>> +struct virtio_i2c_req {
>>>> +        le16 addr;
>>>> +        le16 flags;
>>>> +        le16 len;
>>>> +        u8 buf[];
>>>> +        u8 status;
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +The \field{addr} is the address of the I2C slave device.
>>>> +
>>>> +The first bit of \field{flags} indicates whether it is a read or writ=
e request.
>>>> +It means a read request if the first bit of \field{flags} is set, oth=
erwise
>>>> +it is a write request. The rest bits of \field{flags} are reserved.
>>>> +
>>>> +The \field{len} is the number of data bytes in the \field{buf} being =
read from or
>>>> +written to the I2C slave address.
>>>> +
>>>> +The \field{buf} of the request contains one segment of an I2C transac=
tion.
>>>> +If the first bit of \field{flags} is '1', the \field{buf} is written =
by the
>>>> +device and it contains one segment of an I2C transaction being read f=
rom the
>>>> +device.
>>> Let's give a name to the flag then? READ I guess?
>>> I guess this means it's an exact reverse of the write-only/read-only
>>> flag in the descriptor?
>>> I still think it's both a potential source of errors and a waste
>>> to have this bit in the device struct when we have a generic one.
>>>
>>> How about adding some motivation to explain why it's done
>>> like this?
>> Hmm... It seems the description here is a bit unsatisfactory. I don't me=
an
>> to use this flag
>> to play the role of that flag of the descriptor. I just want to encapsul=
ate
>> all the i2c_msg fields
>> into the request for I2C use. The flag in the descriptor is defined from
>> virtio perspective
>> while the flag in this request is defined from I2C perspective.
>> It may be necessary to reverse the cause and effect:
>>
>> It seems better to say "If it is a write request (write descriptor), the=
n
>> the first bit of the flag in the request should be set to 0."
>> than "the first bit of the flag in the request is 0, then it is a write
>> request (write descriptor)".
>>
>> I will try to add more description to make it looks better.
>>
>> Thanks.
>
> I think it's better to have the device take it from the virtio descriptor=
 though.
> Duplicating info just causes bugs ...
So do you tend to delete the flags from virtio_i2c_req ?
>>
>>>> If the first bit of \field{flags} is '0', the \field{buf} is written
>>>> +by the driver and it contains one segment of an I2C transaction being=
 written
>>>> +to the the device.
>>> one the?
>>>
>> Right. Thanks for your careful review.
>>
>>
>>> more detail on how are multi-segment transactions formed?
>>> don't you need flags to start/stop?
>>>
>> Currently, it is designed to simply transparently transmit
>> the "i2c_msg messages" from the frontend OS kernel to the backend.
>  From spec perspective we don't really care. We also don't
> assume driver and device are using linux.
I agree.
>> No need to tag the start/stop segment.
>>
>> Thanks.
>
>
> i2c_msg has flags to signal start/stop of multi-segment transactions.
>
Which flags ?

This adapter only declares following I2C functionality for this moment.

I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;

So I think we only need the flag "I2C_M_RD" for transaction.

And if you think "I2C_M_RD" is redundant, I can remove the two byte=20
flags from

virtio_i2c_req.

Thanks.

>>>> +The final \field{status} byte is written by the device: either VIRTIO=
_I2C_MSG_OK
>>>> +for success or VIRTIO_I2C_MSG_ERR for error.
>>>> +
>>>> +\begin{lstlisting}
>>>> +#define VIRTIO_I2C_MSG_OK     0
>>>> +#define VIRTIO_I2C_MSG_ERR    1
>>>> +\end{lstlisting}
>>> what if one segment in a transaction fails?
>> The driver shall return the number of segments successfully processed.
>>
>> Thanks.
> where would it return it?
The requests are being handled in order, so we can return the number of
the last segment being successfully processed.

Thanks.

>>>> 2.7.4

--------------0C3A72F49573A16C88CB0272
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p>On 2020/10/28 19:27, Michael S. Tsirkin wrote:<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201028072253-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Wed, Oct 28, 2020 at 03:54:=
39PM +0800, Jie Deng wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">
On 2020/10/27 20:20, Michael S. Tsirkin wrote:
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">On Tue, Oct 27, 2020 at 02=
:00:24PM +0800, Jie Deng wrote:
</pre>
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">virtio-i2c is a virtual =
I2C adapter device. It provides a way
to =EF=AC=82exibly communicate with the I2C slave devices from the guest.

This patch adds the specification for this device.

Signed-off-by: Jie Deng<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:ji=
e.deng@intel.com">&lt;jie.deng@intel.com&gt;</a>
---
  conformance.tex | 28 ++++++++++++++---
  content.tex     |  1 +
  virtio-i2c.tex  | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
  3 files changed, 119 insertions(+), 4 deletions(-)
  create mode 100644 virtio-i2c.tex

+The driver queues requests to the virtqueue, and they are used by the
+device. The request is the representation of one segment of an I2C
+transaction. Each request is of form:
+
+\begin{lstlisting}
+struct virtio_i2c_req {
+        le16 addr;
+        le16 flags;
+        le16 len;
+        u8 buf[];
+        u8 status;
+};
+\end{lstlisting}
+
+The \field{addr} is the address of the I2C slave device.
+
+The first bit of \field{flags} indicates whether it is a read or write req=
uest.
+It means a read request if the first bit of \field{flags} is set, otherwis=
e
+it is a write request. The rest bits of \field{flags} are reserved.
+
+The \field{len} is the number of data bytes in the \field{buf} being read =
from or
+written to the I2C slave address.
+
+The \field{buf} of the request contains one segment of an I2C transaction.
+If the first bit of \field{flags} is '1', the \field{buf} is written by th=
e
+device and it contains one segment of an I2C transaction being read from t=
he
+device.
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">Let's give a name to the f=
lag then? READ I guess?
I guess this means it's an exact reverse of the write-only/read-only
flag in the descriptor?
I still think it's both a potential source of errors and a waste
to have this bit in the device struct when we have a generic one.

How about adding some motivation to explain why it's done
like this?
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Hmm... It seems the descript=
ion here is a bit unsatisfactory. I don't mean
to use this flag
to play the role of that flag of the descriptor. I just want to encapsulate
all the i2c_msg fields
into the request for I2C use. The flag in the descriptor is defined from
virtio perspective
while the flag in this request is defined from I2C perspective.
It may be necessary to reverse the cause and effect:

It seems better to say "If it is a write request (write descriptor), then
the first bit of the flag in the request should be set to 0."
than "the first bit of the flag in the request is 0, then it is a write
request (write descriptor)".

I will try to add more description to make it looks better.

Thanks.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">

I think it's better to have the device take it from the virtio descriptor t=
hough.
Duplicating info just causes bugs ...
</pre>
    </blockquote>
    So do you tend to delete the flags from <span class=3D"fontstyle0">virt=
io_i2c_req
    </span> ?<br style=3D" font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: normal;
      orphans: 2; text-align: -webkit-auto; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px; ">
    <blockquote type=3D"cite"
      cite=3D"mid:20201028072253-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">If the first bit of \fie=
ld{flags} is '0', the \field{buf} is written
+by the driver and it contains one segment of an I2C transaction being writ=
ten
+to the the device.
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">one the?

</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Right. Thanks for your caref=
ul review.


</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">more detail on how are mul=
ti-segment transactions formed?
don't you need flags to start/stop?

</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Currently, it is designed to=
 simply transparently transmit
the "i2c_msg messages" from the frontend OS kernel to the backend.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
From spec perspective we don't really care. We also don't
assume driver and device are using linux.
</pre>
    </blockquote>
    I agree. <br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201028072253-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">No need to tag the start/sto=
p segment.

Thanks.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">


i2c_msg has flags to signal start/stop of multi-segment transactions.

</pre>
    </blockquote>
    <p>Which flags ?<br>
    </p>
    <p>This adapter only declares following I2C functionality for this
      moment.<br>
    </p>
    <p>I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;</p>
    <p>So I think we only need the flag "I2C_M_RD" for transaction.</p>
    <p>And if you think "I2C_M_RD" is redundant, I can remove the two
      byte <span class=3D"fontstyle0">flags from</span></p>
    <p><span class=3D"fontstyle0">virtio_i2c_req</span>.</p>
    <p>Thanks.<br style=3D" font-style: normal; font-variant: normal;
        font-weight: normal; letter-spacing: normal; line-height:
        normal; orphans: 2; text-align: -webkit-auto; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-size-adjust: auto;
        -webkit-text-stroke-width: 0px; ">
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201028072253-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">+The final \field{status=
} byte is written by the device: either VIRTIO_I2C_MSG_OK
+for success or VIRTIO_I2C_MSG_ERR for error.
+
+\begin{lstlisting}
+#define VIRTIO_I2C_MSG_OK     0
+#define VIRTIO_I2C_MSG_ERR    1
+\end{lstlisting}
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">what if one segment in a t=
ransaction fails?
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
The driver shall return the number of segments successfully processed.

Thanks.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
where would it return it?
</pre>
    </blockquote>
    <span class=3D"fontstyle0">The requests are being handled in order, so
      we can return the number of</span><br>
    <span class=3D"fontstyle0">the last segment being</span> successfully
    processed.<br style=3D" font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: normal;
      orphans: 2; text-align: -webkit-auto; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px; ">
    <p>Thanks.<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201028072253-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">
2.7.4
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
  </body>
</html>

--------------0C3A72F49573A16C88CB0272--

