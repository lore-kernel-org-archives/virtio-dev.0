Return-Path: <virtio-dev-return-11449-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316D1C64EC4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 16:22:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5BDECF3F4A
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 16:22:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53C769866C9
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 16:22:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 48EE59866B8; Mon,  6 Mar 2023 16:22:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 350649866B9;
	Mon,  6 Mar 2023 16:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM/zjdbNWx5DukDoRBHvmrkvzOR+CEKmuUmi3DSjODdZ9GoB0FUV4kdxYvqTExKmYh9NscIBpeR/NQlYBAJRKp+uAcjWiQOppqlkzlnJstx0gJXICrbeCEkoYqQvTEt5bHev8WTcfiq3dNSyRkkWCrI75nx9V+q9P3EFDZ/E0PselLZ8a/z381wuwwdEJItaCvDRfueGOMAqRwa/Gh3Ez8tLRjRP9UEIdfFQm3YFdHVDcXCWq+W2EJuIAW29FmNg7Ox7sjW+/3NXvFQfHFCR23ypwrHppjXSgc8M22YYcbFa/VeFqxJiIjCjaBalHX4ojMzsOI9a4rTvnlidoUg+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GnrKJMa/o4QrKs5P7iUhylna2LvEkEyoPOS2Mjbg4E=;
 b=LJqxEVZEZ0ApSwtLHv2lHObw0ySFxovVISg0CARjZOCNX4y+8752I1leKw+ijbAJgpCw6Dt7vC1GYEiCOVd8iyzmiORLlAgAjYeovX3f47+E32droiTfCZSaE1yf8yBNSzM3h6SvWkUpaT0oedXDH/fjznQQpI/NQen7WRAcEUJ/6ERr9sGHH1qTul9YyV0+rCd2adw0NLMUqp0xHBInLBBwOpL6ooxtBNWWGSn3HC5SjR1wB4G6mAmPIrjRycGkjafZwDugj8XO4PV8xceFX4eiuRzUWxHvBlNbhvIqEdG58AsC9w1wi0+pU+ZOXT75g4zagOD0wbx1X5oq/RJZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Mon, 6 Mar 2023 17:22:21 +0100
From: Jiri Pirko <jiri@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	sgarzare@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZAYTPeXUNevSFtOE@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <e8d41902-b794-66e9-8f15-e8617435047c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8d41902-b794-66e9-8f15-e8617435047c@redhat.com>
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f560f51-f070-4cf1-51a6-08db1e5ef92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LaBouiK2YszfCcNHcmwssr7qdIsW8XAAt537gOI6Jq5dhTbCxGuorMW4FNNjwAs/d16Lz3E9DJuzsvFlRhSwlz6FbN1MzbLWZ5A4emJOjMVmi3jxcaE5GjtdEX/L6OiRQ7hDZLCDZ3+BXIzyQtDawnVc8T5iNdXSVB8Bqn3VBxYbnc+OoiYY84HoO5oVjtESCrnFy9PQp20wUXfGkb0PZjXyPCHPYtIvD8rh2YDbK/0mDCwXWQ+Vfmv6ppcfH0pZBSHEg3Ez2eEIXMGR5PrzpuTvLRnOyJd2yeH770+aaKB9kfxMu5OCKQ7w+7gqWDfjueQYrXYnSa3uoIMPE+L6+UQSRg2AmhOtpHYW23j3oZWNSAowRq+02KAt2HHtk5QSP2L5z1DvyCp+diWrJJeRprWWJjiF5+qjrbloD/K6/Y9ftJoo9SoTnWfOx6CV5qLLSLNIV2+jENnt6dQocbGDym5WKT8AH8Fd6JQ1Z1HwLtqqpw28t9zFEzjVu/FZzf6J19Vo62PSGZNL58Rl/Z74FgaWM8RMFdc5WUoGxEogsRj7wcR2XzEofhJchZdffX1o3EEQ8EOyvTSoOhnhZT6zocg4gU74PYuBfjVh/oJdkTu4lRt9yoVayLb+FFry/D9JlGFi48tn63rze7whbAvIN1MAP5UxSX+9QxPyfIvTd/ADiLmYc4HwIK+crbZTEixV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199018)(66899018)(33716001)(478600001)(83380400001)(6666004)(107886003)(16799955002)(316002)(38100700002)(54906003)(6512007)(26005)(9686003)(6486002)(6506007)(186003)(5660300002)(66476007)(2906002)(7416002)(86362001)(66556008)(66946007)(8936002)(41300700001)(6916009)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzNta0IveTZITkpDdVdvb2pJcU1VUXF2aFlXdGxUT3VNbnloMnJOT1VibWZ5?=
 =?utf-8?B?REZCK3BBWlZBL2kwNkNDbFJLWWlzRUFvVXBQV2czeS9HdHFjeDNIY3R4STQw?=
 =?utf-8?B?QTdkNXE0ZnBZbFZacmRsTlJpSjRnczFvVi9BTWt6bmtSVC9zRCtGSW4xelRa?=
 =?utf-8?B?ajFJUFNPVTd4Rmk3RUF4SVBoV1NFbjBzMk8zc25NdGVMVkhLOE9yZ3NjWk9Q?=
 =?utf-8?B?Qnlxcjd1ZnFOeEorN0ZXa0xCdUFPK2MwVXVWa0xYMzZPM2RlbGxVaTVQeksy?=
 =?utf-8?B?NHkyWmJXOFpoaktYMzhoaVJwQTBlUG8rR2ZnTzRKNWc5ZVZDWHJ0R1JtaXJo?=
 =?utf-8?B?RTFrcEhvTDBNOVNNbGdHR3o1YXBKR1pHZnlTU2pmbG9sYWV0MlQ0bGdmYmR2?=
 =?utf-8?B?UVFpQkVkVGdXdlc0dW5HdGk4Q1orVEZ1NE9PcUtrbkRGdWk4QmZzRWU3cVJM?=
 =?utf-8?B?a3VWbE1HWjFCRXFuUVk4OEJUNWY2TVphazZrQUxNQUk1UUJEbTdyRkJiU3Y0?=
 =?utf-8?B?bXFsUGN6NUtCVDJZMGtLaFB3MkxLNytFdFFVVmNxa2V0QW9LbEdNTWVyYTdl?=
 =?utf-8?B?Mjh4dGFRM1RGaTRHYlNEc1kyclpNRkJaVklqS1V0QnFWcmVoKzdDeDhScXFt?=
 =?utf-8?B?NmRoNWtyTXdMcW1BTTJjenRBODdJKzJLK0VPQnFmRFFnRms4Qkk1M1VxZG9o?=
 =?utf-8?B?QUpDSjd0QjBKb0lmd0JVVGQrMUhzODJlWFpYUWtOOEZoZ1BIdUN3ZDVualp5?=
 =?utf-8?B?K0RvQU4xSTBDV1p0Uk5aYmFRVTJNMzRoQVNSTGlqM2hRWFZmcndoYjZpRUZK?=
 =?utf-8?B?bG0rS0h0S3NENUlGT1lLcTZ5WWRGUE00WmtmU3d0TW40Z3Q4MGQ5dTE0V0N2?=
 =?utf-8?B?TTRobkIwTVpHWG1SbnBWczQ1UnhPa04xY0VKVjNFdFhBOHpqeUk1a2ExcGdR?=
 =?utf-8?B?UU9yUmh1MXltRnhzWS9obHpiZVQvdVVvUkhRRHZqdGhxRTgwdGpYRjhlRG9S?=
 =?utf-8?B?WkJ5cE9pWXdodWZGWTN3L3hWTlNMM2xRMmhmY25PTUZ6Rm00TVJoRTBxbVVB?=
 =?utf-8?B?R3h1YksxTG15a2NXVWNLRlk5OHJWUU1KVXFXbEhYa2dZTTFFRXZwNHNVOFRL?=
 =?utf-8?B?NWVVc2VCd2V3NWdDUFhpd09PS1V2MlB0cGh6aVdveFU4ajF4ZkJnemFXV0pa?=
 =?utf-8?B?MjArMkhkUXYwTGh2VllSc2FyNEFuaUpCUExleXI1ZFZjeHdHbGg4MmNZeEpL?=
 =?utf-8?B?YWRURVhETjlGSEkzMkxiaFN2a054ci8vK2dja2UvUUYvd0VvSXFBSGNyMk5S?=
 =?utf-8?B?M2V6TlE3NkdGV1JVUzRRd0xtM2xtZFhOYTdQdmFHVnQyV3FObVlMRnQyMHo5?=
 =?utf-8?B?cmFNZXpqY3U4dEx5ZU1rV2ErUlNSOXFSYnF2Ujl4SmR6SXlHaXl1Z2NWT3V6?=
 =?utf-8?B?MStJMDVoV29yeHY5alhCZUlEU1ZnV0dJOHZGRHk3bkdKQmFzc1pPcDd2Y0lF?=
 =?utf-8?B?MXhQd2dYcWNXSjdydGNoeVdZMjhOTm9sRmc5TklwK3lkb1M0VUMyMTFPbVRG?=
 =?utf-8?B?TzVqMC9MN1ptdnZyUCsxTVA0VHVadTBJRTJqNk9JRTQxZ0N6NHBZWHpEb25T?=
 =?utf-8?B?ZEpGMHFpdU5uT25oMXlFMHBXVUI3SUtPWlhJMzBheUNOdSt3UWZwZXhudzlU?=
 =?utf-8?B?WVVFcitvcGdMWHczUzZEY0wvRGxiaGNiZnhXK0pxQ2FkVkMxNEdjcUZQWE4y?=
 =?utf-8?B?QjNJNHdqK1VqeTdLeW1jYkU5MTlpNmlvSWdrcVRBdjlCL0xUdXdER0VaUEM2?=
 =?utf-8?B?b1lmR2drS3JIaWhxS2hTdzM0OHhyUExSWjBQek1xRGJqak1ZMGg3bkFNN3RZ?=
 =?utf-8?B?aXI1SkFhaEhoVDJyVzZ3MmttMUFmS2RubnRzUVM0WXZGUFRTZmdRZlBMRDNY?=
 =?utf-8?B?MVZUM3RKeHdBTTJJamtqemgxb2NZb2dsb1Vmek5DN0xLM2crM3ZsWU5SbWlH?=
 =?utf-8?B?SG9TdGJzSnZnWk1ZUkZnckF4c1paVHNCTUlIWldYdEZtbmJWZDhGd0pvOENR?=
 =?utf-8?B?WXNWQnJWMCtzOGkwbU5TcDd0MDRqb0JJSG9QaFA1Ukxsa2ZoWlRON0VXS085?=
 =?utf-8?Q?ftMYi5eKeRbRnuZMJFuJ3vV48?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f560f51-f070-4cf1-51a6-08db1e5ef92e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:22:26.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/SHSRsY95RpNz0P6+IPI1x5Vt4VXcZ3fdbhFo3YbW8n+wHulXryvlt3AhsFCX8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
Subject: [virtio-dev] Re: [virtio] Re: [PATCH v10 04/10] admin: introduce virtio admin
 virtqueues

Mon, Mar 06, 2023 at 08:58:12AM CET, jasowang@redhat.com wrote:
>
>在 2023/3/3 08:05, Michael S. Tsirkin 写道:
>> On Thu, Mar 02, 2023 at 03:40:07PM -0500, Stefan Hajnoczi wrote:
>> > On Thu, Mar 02, 2023 at 08:05:06AM -0500, Michael S. Tsirkin wrote:
>> > > The admin virtqueues will be the first interface to issue admin commands.
>> > > 
>> > > Currently virtio specification defines control virtqueue to manipulate
>> > > features and configuration of the device it operates on. However,
>> > > control virtqueue commands are device type specific, which makes it very
>> > > difficult to extend for device agnostic commands.
>> > > 
>> > > To support this requirement in a more generic way, this patch introduces
>> > > a new admin virtqueue interface.
>> > Is this referring to the existing virtio-net, virtio-scsi, etc control
>> > virtqueues?
>> > 
>> > I see the admin virtqueue as the virtqueue equivalent to transport
>> > feature bits. The admin queue does nothing device type-specific (net,
>> > scsi, etc) and instead focusses on transport and core virtio tasks.
>> > 
>> > Keeping the device-specific virtqueue separate from the admin virtqueue
>> > is simpler and has fewer potential problems. I don't think creating
>> > common infrastructure for device-specific control virtqueues across
>> > device types worthwhile or within the scope of this patch series.
>> yes this commit log is outdated. referred to original
>> proposal by Max which also planned to replace cvq.
>
>
>Any advantages of allowing PF to change VF's filters? If you're referring

Which filters are you referring to?


>provisioning, the semantic should be different:
>
>1) using admin virtqueue to provision attributes of mac, #vpqs
>2) once the provisioning is done, we should fail another provisioning request

Wait. Why are you assuming provisioning of any kind? In which patch this
is covered?


>
>But 1) should be different from what is used for ctrl vq which is designed
>for the use of the driver not the management.
>
>Thanks
>
>
>> will update.
>> 
>> 
>> > > We also support more than one admin virtqueue, for QoS and
>> > > scalability requirements.
>> > > 
>> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > > ---
>> > >   admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> > >   content.tex |  7 +++--
>> > >   2 files changed, 79 insertions(+), 2 deletions(-)
>> > > 
>> > > diff --git a/admin.tex b/admin.tex
>> > > index 7e28b77..3ffac2e 100644
>> > > --- a/admin.tex
>> > > +++ b/admin.tex
>> > > @@ -155,3 +155,77 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>> > >   \field{command_specific_data} and \field{command_specific_result}
>> > >   depends on these structures and is described separately or is
>> > >   implicit in the structure description.
>> > > +
>> > > +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>> > > +
>> > > +An administration virtqueue of an owner device is used to submit
>> > > +group administration commands. An owner device can have more
>> > > +than one administration virtqueue.
>> > > +
>> > > +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
>> > > +or more adminstration virtqueues. The number and locations of the
>> > > +administration virtqueues are exposed by the owner device in a transport
>> > > +specific manner.
>> > > +
>> > > +The driver submits commands by queueing them to an arbitrary
>> > > +administration virtqueue, and they are processed by the
>> > > +device in the order in which they are queued. It is the
>> > > +responsibility of the driver to ensure ordering for commands
>> > > +placed on different administration virtqueues, because they will
>> > > +be executed with no order constraints.
>> > Does "they are processed by the device in the order in which they are
>> > queued" mean only 1 admin command can be running at any given time and
>> > therefore they will complete in order? This would allow pipelining
>> > dependent commands but prevent long-running commands because the
>> > virtqueue is blocked while executing a command.
>> we have multiple vqs for that.
>> 
>> > > +
>> > > +Administration virtqueues are used as follows:
>> > > +\begin{itemize}
>> > > +\item The driver submits the command using the \field{struct virtio_admin_cmd}
>> > > +structure using a buffer consisting of two parts: a device-readable one followed by a
>> > > +device-writable one.
>> > > +\item the device-readable part includes fields from \field{opcode}
>> > > +through \field{command_specific_data}.
>> > > +\item the device-writeable buffer includes fields from \field{status}
>> > > +through \field{command_specific_result} inclusive.
>> > > +\end{itemize}
>> > > +
>> > > +For each command, this specification describes a distinct
>> > > +format structure used for \field{command_specific_data} and
>> > > +\field{command_specific_result}, the length of these fields
>> > > +depends on the command.
>> > > +
>> > > +However, to ensure forward compatibility
>> > > +\begin{itemize}
>> > > +\item drivers are allowed to submit buffers that are longer
>> > > +than what the device expects
>> > > +(that is, longer than the length of
>> > > +\field{opcode} through \field{command_specific_data}).
>> > > +This allows the driver to maintain
>> > > +a single format structure even if some structure fields are
>> > > +unused by the device.
>> > > +\item drivers are allowed to submit buffers that are shorter
>> > > +than what the device expects
>> > > +(that is, shorter than the length of \field{status} through
>> > > +\field{command_specific_result}). This allows the device to maintain
>> > > +a single format structure even if some structure fields are
>> > > +unused by the driver.
>> > > +\end{itemize}
>> > > +
>> > > +The device compares the length of each part (device-readable and
>> > > +device-writeable) of the buffer as submitted by driver to what it
>> > > +expects and then silently truncates the structures to either the
>> > > +length submitted by the driver, or the length described in this
>> > > +specification, whichever is shorter.  The device silently ignores
>> > > +any data falling outside the shorter of the two lengths. Any
>> > > +missing fields are interpreted as set to zero.
>> > > +
>> > > +Similarly, the driver compares the used buffer length
>> > > +of the buffer to what it expects and then silently
>> > > +truncates the structure to the used buffer length.
>> > > +The driver silently ignores any data falling outside
>> > > +the used buffer length reported by the device.  Any missing
>> > > +fields are interpreted as set to zero.
>> > > +
>> > > +This simplifies driver and device implementations since the
>> > > +driver/device can simply maintain a single large structure (such
>> > > +as a C structure) for a command and its result. As new versions
>> > > +of the specification are designed, new fields can be added to the
>> > > +tail of a structure, with the driver/device using the full
>> > > +structure without concern for versioning.
>> > > +>>>>>>> 0edc690... admin: introduce virtio admin virtqueues
>> > A merge conflict line crept into the patch?
>> yes. I fixed it I thought but somehow it's still there :(
>> 
>> > > diff --git a/content.tex b/content.tex
>> > > index ffe45c4..c8647c9 100644
>> > > --- a/content.tex
>> > > +++ b/content.tex
>> > > @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>> > >   \begin{description}
>> > >   \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>> > > -\item[24 to 40] Feature bits reserved for extensions to the queue and
>> > > +\item[24 to 41] Feature bits reserved for extensions to the queue and
>> > >     feature negotiation mechanisms
>> > > -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
>> > > +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
>> > >   \end{description}
>> > >   \begin{note}
>> > > @@ -7682,6 +7682,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>> > >     that the driver can reset a queue individually.
>> > >     See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>> > > +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
>> > > +  administration virtqueues.
>> > > +
>> > >   \end{description}
>> > >   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>> > > -- 
>> > > MST
>> > > 
>> 
>
>
>---------------------------------------------------------------------
>To unsubscribe from this mail list, you must leave the OASIS TC that
>generates this mail.  Follow this link to all your TCs in OASIS at:
>https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

