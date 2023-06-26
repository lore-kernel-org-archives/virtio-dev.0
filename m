Return-Path: <virtio-dev-return-13069-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C63EB64D7
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 03:56:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D1DDB16DFC6
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 03:56:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB9C5986407
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 03:56:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF9F798635B; Mon, 26 Jun 2023 03:56:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A405C986364;
	Mon, 26 Jun 2023 03:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns9exmOzvWBV3gtj1TeNVaOoNK/wCa1kPtL9rXQBkcaXV5hSBzwpCGDLTb47RZK712iOTUSixMXUHKBvdD015Ics7SYeCLpqTNn/vplox+6hAAwB5DYVjxzXyed/+JdI9Ft+fiMdPx1anTGBsKCU8j7OX3AvwbU0jvcx/6WMfdyinUO7s6YmMnBH29ayt1UTDreTS65OKX+2SvzBap9pno8iwBvFtlft/lCyL2tAsH0N/Q18G/btyc9sJXMy06h0Sx+bqt+EWN37edRbYfLn+k535rmPKQYCVZcETeOTPUQJD10iO0T9cGuuIGvE/B4XW6Ss96QdZi0V4SwnnZdYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+70MG6t2E0WYsyX2miA2fFimhnGhZV8xTFCyvRo1B8=;
 b=VdFB3iGjDjttigmbmQAC2zOPd5lePtWRUPQM/fwbZ075mm1+2sYNA/tH70oK7Ff5EgYWjlPffgRU+mZxrnvTTonB0T/9UcO+TDOoYHZlm00RszYO98qQaL8+esC/VLtzoiqe7M6voE3V4208lhJy5P0XohV0a8ABSG/+AL26D4hAlu1gRxRBcP7ZxO02+RmYZTj6NMm8+QNzdSk1pqy05DTqx2BpdtUQUa4g61QtjhzT1N+KahUhuriD1XcqGCKIZBEdYFInwkY08UOWw0lfnAqKiWlqEwcGTHgi3dVI69Vv+jPOSPHxnvbgPQcMWU+3v3FtM215Gl409QRnwMA38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgAAF5ECAAAQjAIAAAcxggAACF4CAAAAyYIAAAZcAgAAARXCAADjCgIAAD1EAgBp8jwCAAAE3EA==
Date: Mon, 26 Jun 2023 03:55:55 +0000
Message-ID:
 <PH0PR12MB5481EFF93BD449B00EAA302EDC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
 <CACGkMEtPKh-fEkjPu2iPeV5uXus0W7J1V94q1VHVWv-jJHYWGQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEtPKh-fEkjPu2iPeV5uXus0W7J1V94q1VHVWv-jJHYWGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7169:EE_
x-ms-office365-filtering-correlation-id: 0af5f89c-1996-45c8-c4db-08db75f93e71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z8eop0ETnPYeAN+nCYef/X11wTIAsAUG5AVq2DZAdq9CGDkcH7fo1VYWIbPviAUqm9KjPoGNZ2vpMC8WKvMjnDmNvYvi8szSoCsuzppIFSX8fCmVjQ9bLOTn/tuF4qrSoX9vXr3VtrdJQQic01Etu5ceF9oX6MdEEA1GS9pFl+oJNPLeghXJ73VQprbQojmquBj2Cb+FgHraVMlpTc6GGKhUe5qmCYp5kbCGUhDrKPSqZLwlWGPkMsx/AN+iDqjKxN5zVgse9F03n2KMuSmiE3zo1bvKW/mEtRWJhLrQdvgoFankCgQJ9x/Cj6OLi9XAfD/EDWRzAxAvhNg8Qk/GdoRa6dW0vu69Qi+VlO3kgnPNAITw4vdVJRpyRg4To6uupl36SME2ixCzMYS5CjTRsJzxT3JU7AsTuIQeX4bL3Ux8RAVDnqTKPUzeVrzqwrfGFczFIwVh8PLVHmlttUJEXGhNHerv0OBXQ8v3RWfywHTmlFk5rHRjTaKq/TiYO+XVfsQthcMIH7XfLyH71hRjSViWx5SbubB2NBD6GHOwyJ3Jb4hJw3vFoPEtKnhOEqikF65ptv+F8A+LXPpCZwhNLZ/ATUj6WaHa22RjKCB+f+BoZUQNxqJD/4YRDWk1lART
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(33656002)(52536014)(5660300002)(86362001)(8936002)(8676002)(41300700001)(38070700005)(66556008)(64756008)(66476007)(76116006)(4326008)(38100700002)(122000001)(316002)(66946007)(55016003)(107886003)(9686003)(6506007)(26005)(186003)(4744005)(2906002)(66446008)(7696005)(71200400001)(54906003)(478600001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlV3bDdmSEZpMk0yZ2hoTWcrZWRjSXpIUU9DYXFRNGJnSThwbWY2Mm90cnF5?=
 =?utf-8?B?TWxDT0ZhU29scXh0UWFWWUJoUTlySFhPcGNOTklOc0NsVDRBV0wzRUhweGpP?=
 =?utf-8?B?V2lVQWdWYzNMcllyRlBhQjlkNW91L1JNZlpMbjF1bTFLaEkwQkM3blREQWFt?=
 =?utf-8?B?cFZiSFVOanBDMjJxWnJCY3l6SXNTNmF4cm9PZUdFNDhBbnpyZkVBNUpwMWM2?=
 =?utf-8?B?UERhclllRHM2MXNxaU1UQVBkekNyRlZ3QmlqOUFuZnNHdGhuWVFrTEEraW5I?=
 =?utf-8?B?UUlRVGw5WG1JQ0IyTEZqVDNTZnM1MjVOZVdWQmxJNUd3N01iOVc4Wm80YS9x?=
 =?utf-8?B?cUxVYlN0QVhRWEVQR0FqaG1nMTJBQy9ieWFaL2kxZHVHaEFPSDBUSlJjenRk?=
 =?utf-8?B?TXd3UW1UNk9KMzlOR0Y4TWFqR0l5d2gxY0QyYmpGMDVJOWxRNmJYdmhVdzBM?=
 =?utf-8?B?eWhCKzJZZUJLNEV4RlMzd0cxMXFZWnlkMlJIM2pEQ0FESXdzbTE4QmF0UDJl?=
 =?utf-8?B?RUg5T0ZBOFpINVF1TkF4NVdjSWNkUTNLUHJ6Wkg0Rit1Y1Urei9DSHltS295?=
 =?utf-8?B?Zy9lazdOWnNlWDdlU0JkOXRHUUR3aXJwUXd1bm8xQ29rMWpsL3BGSWNOVkZn?=
 =?utf-8?B?RnZiWlpMbkR1anliS0lKdDMwVXVVakZnMVJMRXpxc2dtUXR6dDlqOTNjdVBm?=
 =?utf-8?B?QUpWdis1ckV5Q2VQd3ZmQ2RUWlJEMGRyN2hsd2cwbnNDc294UkQxUTd6bm44?=
 =?utf-8?B?Snl5ZUZKRWdleEZaZ0hCNHJ5Rkc2eUN3VGtKSG5JR1BoOUduZEc0ZXgvdy8x?=
 =?utf-8?B?SnB1cnZYamlUYjVOcFZIVE1ra2JpcmdUUXZRMVRJRXZ0UFJSYlpxaUgvMzZ3?=
 =?utf-8?B?MmFDdG11MmFWajZ4MGh2cGxuNmlIejVTZDYrVXA5L1NRMGNBM295S0hBWWMw?=
 =?utf-8?B?UTlpeWFTaEttRlM3L3hSUDNMdit3OWxKa0NXSXBFbjFNUllBN2xBVXhYZmRD?=
 =?utf-8?B?ZDBmMlJHUHlEZXpRU3VQQ0ZSSk8yWTk0REpoUzNpRnVXOGM4VEZpVU1ocSt2?=
 =?utf-8?B?ZFBPYmVYZldUTy9hTmlJYzlYVU5NTjJTV3pydHdnWmwrSmZhRzhiamFjQnlQ?=
 =?utf-8?B?TjliVW9vMkJQU1BVN1REL0RHYUlFV0t2czJQUHJqRzdsd1RhaUlycjNUWU53?=
 =?utf-8?B?TXBsOTZvQVNwSFFuQkpYZEdXYWRzaXlhTjY2OWtaR0k1eVduOTZ6eENRRTVn?=
 =?utf-8?B?UU9sbTJOVi9xOCs3S3oweUNqb2I1ekVtNDhJNzZJVkhIdkd4bDdJSHpkeGwy?=
 =?utf-8?B?VDRFR2NrRTV5OUJ4dUpCdXViRndDNmZOZ1VEc2NUcC81ZnNaQ0t5c3ZmRkVO?=
 =?utf-8?B?YUE1VDN5Zy90Vmg5bU44bTJyRXhHQjlSQTdZSUpaOGJmMUh1bjVQVnpiYXNp?=
 =?utf-8?B?SkV4T2orT1Z1R1JhWmRURWxBalpBekN1emhGTlZ5akI1a0RhYVRRbXlIQWhp?=
 =?utf-8?B?YWl3dGVMU3BRVDNrcURxS0tkdzVPZithalZGZFhvR05PUEZnVmtDMFEzZElG?=
 =?utf-8?B?U3VaUEsxRTloWFZwVElxVHlnTFFHTWxsdTZzR1ZsQ0RPUWhtbzB2QzVoODBp?=
 =?utf-8?B?RkZKSjk3V0RzZkgxU3Z0R1BqUWc1YnJhNC91clZxUW9NT1ZwU0xaWm8xdzB5?=
 =?utf-8?B?eTQ0TUV2eTdiaStXK0JQVDIyeXYrL2dWTSsweTc4ZGZIYnU5ZHIyVXFBb3BF?=
 =?utf-8?B?K2xnZFVKcUV5bnltMHRFa2tnTmtpRkx6VUIvdlllcExuVnlKTFpRZGNCQ2RT?=
 =?utf-8?B?YTdhQ09ObXQ3U0NEeFVMNTR1QjJGeGdpeUt5UmVZMGdVNTI0dHl6YWVKcGQ0?=
 =?utf-8?B?UmtCOGdVejRpQlZ5VVR1T0ErV1JjUDRJY0pYQnp4SC9TZ0pab2paQVhQVlg3?=
 =?utf-8?B?aU1xSWJURXJqTXZnNUFpeXBmMEQ3ZGtHWXVrTFFwdHMyVVc3VG5jcEFHdG1U?=
 =?utf-8?B?YWMrSEQzb3B4bE55RUpwVmlZRmVxZmNBVTFQVmdBVzVWRi9kTHg1aXBGMmtO?=
 =?utf-8?B?dkU3TWM2MkN5Smt3ZXlxbkdzWVF3bVBHYVJIRVVwNkVmNkxLQXdZZlVSVFRr?=
 =?utf-8?Q?oBiI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af5f89c-1996-45c8-c4db-08db75f93e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 03:55:55.7515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5SJIlerzvJwcf3kasn39WVsr9oJbz9a9CHYFh8sBgcWEK4cji9RlrcEDc1N0a4+NrK+umqgzdiDwJabX3YSCpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogU3Vu
ZGF5LCBKdW5lIDI1LCAyMDIzIDExOjUwIFBNDQogDQo+ID4gQnV0IGhhcmR3YXJlDQo+ID4gdmVu
ZG9ycyB3aWxsIGRvIHRoYXQgcXVpY2tseSBpZiB0aGV5IGNhbid0IHNlbGwgaGFyZHdhcmUuDQo+
IA0KPiBJdCBsb29rcyB0byBtZSB0aGF0IHByb2R1Y2luZyBhIG1vZGVybiBvbmx5IGRldmljZSB3
aWxsIGJlIG1vcmUgcXVpY2sgYW5kDQo+IGVhc3k/DQpBUSBiYXNlZCBsZWdhY3kgaXMgcXVpY2sg
YW5kIGVhc3kgYXMgb3Bwb3NlZCB0byBvdGhlciBtZXRob2RzIGNhcHR1cmVkIGluIGFsdGVybmF0
aXZlIHNlY3Rpb24gb2YgdGhlIGxhdGVzdCB2Ni4NCg0KV29ya2luZyBvbiB2NyB0byBjb250aW51
ZSBvdmVyIEFRLg0K

