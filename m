Return-Path: <virtio-dev-return-11553-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF01CC64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:25:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 29DA026A33
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:25:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 217C29866F8
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:25:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1343B985E76; Wed,  8 Mar 2023 21:25:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF7AA986312;
	Wed,  8 Mar 2023 21:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGV0IP9/HKLdMhZq01HF0MWsjk8HO1+fFgJYAXbVeGw9acnEGZyo8zis5dQZfz8saIMGqAzyfuLCKeSBFFJrbUdMbtQ5e+rDWQ6+TUJtNMFjb8kmubVZ8nN6DfL9HKV1ygYGGcAbv+mIRKgLWpLV5gNRs3JyJSXz6IJPQtWtfcc2rDHd1D/ybYMxcuAJb95d1tBMFnOUnQ1yoUXIXfnC41oTxPIYdeYjJgcPRStGJf6O0Sxtv0vG3w+sP739qEkIM26p55IfslHCGA4in0uMZovElh+YHaJkDqYDCPV8nzKhKQdhPTgTJDB0VAedA9DQ/y0SDqR8YAHsrd1j0TdhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVTwNIvByT5VJSHpofGn995bG8MsnJGD36mJ8YlwaNs=;
 b=iWvq+sWEjSqM8XSp1NEZm/UGlID2H+5px+PF0WoB40O2FcI2eBN1ucuq0+sQCfSjGEBWOCE8H8voKTPqJZsu2K+d6W+UPM40VZ+yVzG0Yf69jgEm8STZUCnVo2pYw9k9dhYppbC/QKNpxoMXCDB2KO8/KOHLp8k9lBsDB5rfiujfLLSS61cTLixhn8Y2YWWi7suUQsQC+6nhvRTWYRtTgJIQmo2U+OBLquHh1JTWzzeIRRrZ480VGJSSmRuncOx7fjzEGjPfry/qgFkq7UDQ8V7uoG9d9eRYGOUcwlejg+S1NtWLmVxKpIH7eECdrZCJzXoECigLmHXIsJnEX1KmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues
Thread-Index: AQHZUaV1hq+swD5r7EeFCHM9rP6wha7wxScAgAAFDACAAFmxgIAACLQAgAA3RYA=
Date: Wed, 8 Mar 2023 21:25:32 +0000
Message-ID:
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <ZAXfegxCfvfLwiJT@nanopsycho> <20230306133816-mutt-send-email-mst@kernel.org>
 <ZAbpiRVdo8BciELX@nanopsycho> <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho> <20230308064505-mutt-send-email-mst@kernel.org>
 <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com> <m2wn3rxgv5.fsf@oracle.com>
In-Reply-To: <m2wn3rxgv5.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5873:EE_
x-ms-office365-filtering-correlation-id: ba4aaeaa-1752-4386-4d8c-08db201ba5e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 W90OCEH1g+NQeOJBXB4vgYn6wZossmrvjZUF/8xfomQ6UWm4PhgGPfJj+aftfBH/Qa9WxH+FAJFxjzWfsdAuTWHPsGYK3npPYjiQ4jFsb62SY0lK7D/zLhwB9hmUaDG13dUgk7D9nto2m5clIsQEe96Xw6YqjnEVXGx8ZEUsMu0n9LgPllfe/IKKALQSpMnUXDn5JlD4c8KrzpmmDnl60f8lyScIObc2vPBwO/dkWiMEfQDMJfBB9Rj2ELWXs9YDRukfATfV/Ah3VpKt8aL9zlUN+yN4dvosY1hL2NoiAOCgE4x0k6pbEws4xRoxALmBtDsLIRG3RnnZWDdjL2hiYaRpm1l6aIJFxaTH6Lu6dHEHF3v9UzJ0oJJ9O3SKGaNKYJUSx+y0bKKE02R3MKUEMfIZJ7KqrEzoCgPCa33678VjMh1atyLONKRvhViIsTuc8wEmed7aODsxlphxPfCTS6CxtxVojh2c/lZPlvmM3/3g/jtRqP5ojCaM7CcAehL5C2FXGDAuTt6SojRXaZ4rzWLseRN+/Qq2AAnYMA9dxSuR8Ag8zOl32M4KJP4fGui7pYk/s35WrjaXIbe7Br5gXbXU1U0rjLw/t+k0FnLE90yaI7smj7QjnVhXGVOUPHSL1ShAV+Z+vvDtsU4B7603Oqer3h44sB6Q37z1753R+w1Sy3r+xLArXJY/W2oDGpsK22dc1Z5TxViddRUuRqMS7g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199018)(33656002)(2906002)(66946007)(64756008)(41300700001)(8676002)(8936002)(66446008)(66476007)(4326008)(4744005)(7416002)(5660300002)(66556008)(76116006)(38070700005)(122000001)(38100700002)(86362001)(7696005)(71200400001)(478600001)(107886003)(54906003)(55016003)(316002)(6506007)(110136005)(52536014)(83380400001)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ce6MS8H+9c5G+a2yrtvveSBpl/Yw7uG3sJbRV+TSR+hPITYcdNZBBqf6DZN+?=
 =?us-ascii?Q?JwNlb4+0mdBiZAIscyjCPU0yvqU01msLSsUDlc53hUoB9TBB7zxFbnOE/lAW?=
 =?us-ascii?Q?IGnQcFDior4EYzBVAocwrKkz01qtwttUpHax1atQQaOkIFi+SjVmm0yYfUlY?=
 =?us-ascii?Q?k+Ci+yQLNC8z+vPuu+Nj+Wpf+agTskq7z643uGqTDzaSwlCgPZNJnkqoB73B?=
 =?us-ascii?Q?XfdNCXzOc9Q0vNMK40orGRkwVTQNr3/hJ/Ry0o08ks5s+8q19FeI5XbP/Z1X?=
 =?us-ascii?Q?ZFM7mZUASZm5iv88cRs/10PuCUDSoJzT/1Jl7rPRaKYzdBPuV9w4o9wvrJ98?=
 =?us-ascii?Q?J8bMSeo7+t+KVptBFXxLnm+UbqOAgN1FHuIcEhXucpwXf+qm9Oj7StRFIEgK?=
 =?us-ascii?Q?8DKQLjfBWHXji3yAip4Gvq0FqFmM/WNEmzsXGz3G6E25z23OCBCP0c0zL9Jd?=
 =?us-ascii?Q?3INtmcMsMHsn64WkGyjsSbAxCkVt7to4zHVtGzfynrUI/ENDq6u7kIlbRibM?=
 =?us-ascii?Q?9cjvbkwjNXCKp0bbELeLxWNb4hslncoCbC7p8UpH1+V2EWdrg+/vqMAT5boa?=
 =?us-ascii?Q?UKpe0xdCFQVqDgOlukcUZAmZhSG9OZYFy2UJFGbxBy2LoUU7tjCnxMdH0qwr?=
 =?us-ascii?Q?mpaQjuv7Q5rDVguQ1fk/zMNdyK62bETBT0NRQDUFS8NLCvndj9gClpqU59Gb?=
 =?us-ascii?Q?mkTJqiQFqUkfudMnm1vedvwpR6wCuhqXz0WMfsddETrH1HPm9YBTit2dvnee?=
 =?us-ascii?Q?L4Zq+fQnn2aA00bdT4uBgs6AFEy3uTJQFXEHXqEXOeJtDsMz3/HOPOsYBsRy?=
 =?us-ascii?Q?l+wJ2H+KuLL+xqg8mP9mjdRAAvCsVmKQiUrZnbOF5vmXkwz0QwKRFz/eQCxS?=
 =?us-ascii?Q?GC7mRXS4O3X3xW6QGfTYR39tvSz9AzoYvj6m/wXi6dR065Jm7L6MxYVauwfH?=
 =?us-ascii?Q?bQFcSTm1s3abZ60WMUNOac1O296jrF0hpcU4i9H2uIRyhw//03stAD8Xga/v?=
 =?us-ascii?Q?QEtsC6BH+0jezm84xR/qf02Kyde/jfwM9stycXRzmvk31YlujL84eFP9HoMN?=
 =?us-ascii?Q?NaiYUhCf+Jh4/0CRON9/EcF+nm6kGOPo+IFniwQ7mDkrbBAqckRICm+D5kTO?=
 =?us-ascii?Q?tpxK84H/FBzmsdY4qfdfg1T2JOBrcMxwsRqWjzupLD/nEhtBSW5NFAApI5n7?=
 =?us-ascii?Q?iqQ4FlElreDRX21UXkFuRK+dIFIhBJpr2xGchTHe+/7P6AOg3W8Z4SRZ4i6k?=
 =?us-ascii?Q?Nau+KQN/OAX+fPwhxbb7kLeoq/VnPutYVTQT7lF4udhYSdcZCRH80ppYo77L?=
 =?us-ascii?Q?epkicVej25BUTDTTNv9ek4MF0Dc6JJIIM9vyeB9uSFRHUwmNV12luUuR50cC?=
 =?us-ascii?Q?P6+avn9RZDD4ZKiBtllTVpLa/mzP5bMYZ3Wz8MFRa6rFlpxu0SpjynTiRMMr?=
 =?us-ascii?Q?N4hq9i4cdOqHrGcZdgmZ8yEVxqi3hGwYhvAm/ilqF3lCcinlFbdXuF/3tTCv?=
 =?us-ascii?Q?Hbr2kl7IM4mNxUqiCBEToz1HoqP1naZfDpxknlUHnNz/SLyIWVCE16q5XrNF?=
 =?us-ascii?Q?JaaCDIbfgwQjSnMqDxK3NeMYVkHu2mAFiJtvHxRBzTiwOQxhMT/M9CPNj8SK?=
 =?us-ascii?Q?8twpcXZHAUJiWLdN8LgBCC8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4aaeaa-1752-4386-4d8c-08db201ba5e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 21:25:32.2374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lsf3ZpR/LsmnwDpP5DFXLY8P61vHxnBQgqfgQc6QvSkfBs6dsv0utSoro/IBp6CdwECHdQigVvbZPSlM1rBHfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues


> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of David Edmondson

> In support of live migration, might we end up moving large amounts of dev=
ice
> state through the admin queue?
>=20
Correct.

> If so, that would seem to have some performance requirements, though I do=
n't
> know if it would justify multiple admin queues.
DMA of the data through the proposed AQ is supported.

If I understood Max correctly when Max said " This AQ is not aimed for perf=
ormance ",
he means that AQ doesn't have performance requirements as io/network queues=
 to complete millions of ops/sec.

it is several hundred to maybe (on the higher side) thousand ops/sec during=
 LM, provisioning use case.

DMA perspective as you mentioned, AQ still has the same perf requirements a=
s that of regular nw/blk io queues.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

