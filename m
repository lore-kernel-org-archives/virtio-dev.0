Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <04a5ea57-05a0-8a67-dda1-636658e0bf95@nvidia.com>
Date: Thu, 9 Feb 2023 19:47:56 +0200
Subject: Re: [virtio-comment] [PATCH v10 02/10] admin: introduce device group
 and related concepts
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-3-mst@redhat.com> <m2zg9m284x.fsf@oracle.com>
 <20230209100903-mutt-send-email-mst@kernel.org> <m2v8ka273u.fsf@oracle.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <m2v8ka273u.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------B6vUqUGCAng65F2O7HAi0HuH"
Content-Language: en-US
To: David Edmondson <david.edmondson@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--------------B6vUqUGCAng65F2O7HAi0HuH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 09/02/2023 17:22, David Edmondson wrote:
> On Thursday, 2023-02-09 at 10:13:46 -05, Michael S. Tsirkin wrote:
>> On Thu, Feb 09, 2023 at 03:00:58PM +0000, David Edmondson wrote:
>>> On Thursday, 2023-02-09 at 07:13:36 -05, Michael S. Tsirkin wrote:
>>>> Each device group has a type. For now, define one initial group:
>>>>
>>>> SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
>>>> PCI SR-IOV physical function (PF). This group may contain one or more
>>>> virtio devices.
>>> The specification says zero or more generally and nothing to refine that
>>> for SR-IOV groups.
>> Well it says:
>>
>> 	(SR-IOV) physical function (PF) device as the owner and includes
>> 	all its SR-IOV virtual functions (VFs) as members (see
>> 	\hyperref[intro:PCIe]{[PCIe]}).
>>
>> how can that be zero?
> If I remove all of the VFs of a PF, does the group implicitly disappear?

Enable/Disable SR-IOV are dynamic operations controlled by NumVFs register.

We can mention that a group include all virtual functions indicated by 
*TotalVFs*RO register.

This group exist as long as the owner PF supports SR-IOV and has admin 
capabilities.
****

> How about the converse?
>
>>>> Each device within a group has a unique identifier. This identifier
>>>> is the group member identifier.
>>>>
>>>> Note: one can argue both ways whether the new device group handling
>>>> functionality (this and following patches) is closer
>>>> to a new device type or a new transport type.
>>>>
>>>> However, I expect that we will add more features in the near future. To
>>>> facilitate this as much as possible of the text is located in the new
>>>> admin chapter.
>>>>
>>>> I did my best to minimize transport-specific text.
>>>>
>>>> Signed-off-by: Max Gurtovoy<mgurtovoy@nvidia.com>
>>>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>>>> ---
>>>>   admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   content.tex |  2 ++
>>>>   2 files changed, 51 insertions(+)
>>>>   create mode 100644 admin.tex
>>>>
>>>> diff --git a/admin.tex b/admin.tex
>>>> new file mode 100644
>>>> index 0000000..2bc7322
>>>> --- /dev/null
>>>> +++ b/admin.tex
>>>> @@ -0,0 +1,49 @@
>>>> +\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
>>>> +
>>>> +It is occasionally useful to have a device control a group of
>>>> +other devices. Terminology used in such cases:
>>>> +
>>>> +\begin{description}
>>>> +\item[Device group]
>>>> +        or just group, includes zero or more devices.
>>>> +\item[Owner device]
>>>> +        or owner, the device controlling the group.
>>>> +\item[Member device]
>>>> +        a device within a group. The owner device itself is not
>>>> +	a member of the group.
>>>> +\item[Member identifier]
>>>> +        each member has this identifier, unique within the group
>>>> +	and used to address it through the owner device.
>>>> +\item[Group type identifier]
>>>> +	specifies what kind of member devices there are in a
>>>> +	group, how is the member identifier is interpreted
>>>> +	and what kind of control the owner has.
>>>> +	A given owner can control a single group of a given type,
>>>> +	thus the type and the owner together identify the group.
>>>> +	\footnote{Even though some group types only support
>>>> +			specific transports, group type identifiers
>>>> +			are global rather than transport-specific -
>>>> +			we don't expect a flood of new group types.}
>>>> +\end{description}
>>>> +
>>>> +The following group types, and their identifiers, are currently specified):
>>>> +\begin{description}
>>>> +\item[SR-IOV group type (0x1)]
>>>> +This device group has a PCI Single Root I/O Virtualization
>>>> +(SR-IOV) physical function (PF) device as the owner and includes
>>>> +all its SR-IOV virtual functions (VFs) as members (see
>>>> +\hyperref[intro:PCIe]{[PCIe]}).
>>>> +
>>>> +The PF device itself is not a member of the group.
>>>> +
>>>> +The group type identifier for this group is 0x1.
>>>> +
>>>> +A member identifier for this group can have a value 0x1 to 0xFFFF
>>>> +and equals the SR-IOV VF number of the member device (see
>>>> +\hyperref[intro:PCIe]{[PCIe]}).
>>>> +
>>>> +Both owner and member devices for this group type use the Virtio
>>>> +PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
>>>> +\end{description}
>>>> +
>>>> +
>>>> diff --git a/content.tex b/content.tex
>>>> index 0c2d917..ffe45c4 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>>>>   types. It is RECOMMENDED that devices generate version 4
>>>>   UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>>>>   
>>>> +\input{admin.tex}
>>>> +
>>>>   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>>>>   
>>>>   We start with an overview of device initialization, then expand on the
>>> -- 
>>> Tell her I'll be waiting, in the usual place.
--------------B6vUqUGCAng65F2O7HAi0HuH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 09/02/2023 17:22, David Edmondson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:m2v8ka273u.fsf@oracle.com">
      <pre class="moz-quote-pre" wrap="">
On Thursday, 2023-02-09 at 10:13:46 -05, Michael S. Tsirkin wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On Thu, Feb 09, 2023 at 03:00:58PM +0000, David Edmondson wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
On Thursday, 2023-02-09 at 07:13:36 -05, Michael S. Tsirkin wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Each device group has a type. For now, define one initial group:

SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
PCI SR-IOV physical function (PF). This group may contain one or more
virtio devices.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
The specification says zero or more generally and nothing to refine that
for SR-IOV groups.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Well it says:

	(SR-IOV) physical function (PF) device as the owner and includes
	all its SR-IOV virtual functions (VFs) as members (see
	\hyperref[intro:PCIe]{[PCIe]}).

how can that be zero?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
If I remove all of the VFs of a PF, does the group implicitly disappear?</pre>
    </blockquote>
    <p>Enable/Disable SR-IOV are dynamic operations controlled by NumVFs
      register.</p>
    <p>We can mention that a group include all virtual functions
      indicated by <strong style="box-sizing: border-box; font-weight:
        700; color: rgb(64, 64, 64); font-family: Lato, proxima-nova,
        &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(252, 252,
        252); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial;">TotalVFs</strong><span style="box-sizing: border-box; color: rgb(64, 64, 64);
        font-family: Lato, proxima-nova, &quot;Helvetica Neue&quot;,
        Arial, sans-serif; font-size: 16px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        letter-spacing: normal; text-align: left; text-indent: 0px;
        text-transform: none; white-space: normal; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(252, 252,
        252); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial;"> RO register.<br>
      </span></p>
    <p><span style="box-sizing: border-box; color: rgb(64, 64, 64);
        font-family: Lato, proxima-nova, &quot;Helvetica Neue&quot;,
        Arial, sans-serif; font-size: 16px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        letter-spacing: normal; text-align: left; text-indent: 0px;
        text-transform: none; white-space: normal; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(252, 252,
        252); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial;">This group exist as
        long as the owner PF supports SR-IOV and has admin capabilities.<br>
      </span><strong style="box-sizing: border-box; color: rgb(64, 64,
        64); font-family: Lato, proxima-nova, &quot;Helvetica
        Neue&quot;, Arial, sans-serif; font-size: 16px; font-style:
        normal; font-variant-ligatures: normal; font-variant-caps:
        normal; letter-spacing: normal; text-align: left; text-indent:
        0px; text-transform: none; white-space: normal; word-spacing:
        0px; -webkit-text-stroke-width: 0px; background-color: rgb(252,
        252, 252); text-decoration-thickness: initial;
        text-decoration-style: initial; text-decoration-color: initial;"></strong><strong style="box-sizing: border-box; font-weight: 700; color: rgb(64,
        64, 64); font-family: Lato, proxima-nova, &quot;Helvetica
        Neue&quot;, Arial, sans-serif; font-size: 16px; font-style:
        normal; font-variant-ligatures: normal; font-variant-caps:
        normal; letter-spacing: normal; orphans: 2; text-align: left;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial;"></strong></p>
    <blockquote type="cite" cite="mid:m2v8ka273u.fsf@oracle.com">
      <pre class="moz-quote-pre" wrap="">
How about the converse?

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
Each device within a group has a unique identifier. This identifier
is the group member identifier.

Note: one can argue both ways whether the new device group handling
functionality (this and following patches) is closer
to a new device type or a new transport type.

However, I expect that we will add more features in the near future. To
facilitate this as much as possible of the text is located in the new
admin chapter.

I did my best to minimize transport-specific text.

Signed-off-by: Max Gurtovoy <a class="moz-txt-link-rfc2396E" href="mailto:mgurtovoy@nvidia.com">&lt;mgurtovoy@nvidia.com&gt;</a>
Signed-off-by: Michael S. Tsirkin <a class="moz-txt-link-rfc2396E" href="mailto:mst@redhat.com">&lt;mst@redhat.com&gt;</a>
---
 admin.tex   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100644 admin.tex

diff --git a/admin.tex b/admin.tex
new file mode 100644
index 0000000..2bc7322
--- /dev/null
+++ b/admin.tex
@@ -0,0 +1,49 @@
+\section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device groups}
+
+It is occasionally useful to have a device control a group of
+other devices. Terminology used in such cases:
+
+\begin{description}
+\item[Device group]
+        or just group, includes zero or more devices.
+\item[Owner device]
+        or owner, the device controlling the group.
+\item[Member device]
+        a device within a group. The owner device itself is not
+	a member of the group.
+\item[Member identifier]
+        each member has this identifier, unique within the group
+	and used to address it through the owner device.
+\item[Group type identifier]
+	specifies what kind of member devices there are in a
+	group, how is the member identifier is interpreted
+	and what kind of control the owner has.
+	A given owner can control a single group of a given type,
+	thus the type and the owner together identify the group.
+	\footnote{Even though some group types only support
+			specific transports, group type identifiers
+			are global rather than transport-specific -
+			we don't expect a flood of new group types.}
+\end{description}
+
+The following group types, and their identifiers, are currently specified):
+\begin{description}
+\item[SR-IOV group type (0x1)]
+This device group has a PCI Single Root I/O Virtualization
+(SR-IOV) physical function (PF) device as the owner and includes
+all its SR-IOV virtual functions (VFs) as members (see
+\hyperref[intro:PCIe]{[PCIe]}).
+
+The PF device itself is not a member of the group.
+
+The group type identifier for this group is 0x1.
+
+A member identifier for this group can have a value 0x1 to 0xFFFF
+and equals the SR-IOV VF number of the member device (see
+\hyperref[intro:PCIe]{[PCIe]}).
+
+Both owner and member devices for this group type use the Virtio
+PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
+\end{description}
+
+
diff --git a/content.tex b/content.tex
index 0c2d917..ffe45c4 100644
--- a/content.tex
+++ b/content.tex
@@ -491,6 +491,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\input{admin.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">-- 
Tell her I'll be waiting, in the usual place.
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------B6vUqUGCAng65F2O7HAi0HuH--

